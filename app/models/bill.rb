# frozen_string_literal: true

class Bill < ApplicationRecord # rubocop:disable Metrics/ClassLength
  include PgSearch
  pg_search_scope :search, 
                  against: %i[title number breakdown summary], 
                  using: { tsearch: { prefix: true } }
  # Gems
  include SyncCache
  has_one_attached :banner

  # Associations
  belongs_to :congress
  belongs_to :topic, optional: true
  has_many :sponsorships, dependent: :destroy
  has_many :sponsors, through: :sponsorships, source: :member
  has_one  :sponsorship, -> { Sponsorship.primary }, class_name: 'Sponsorship'
  has_one  :sponsor, through: :sponsorship, source: :member
  has_many :cosponsorships, -> { Sponsorship.cosponsor }, class_name: 'Sponsorship'
  has_many :cosponsors, through: :cosponsorships, source: :member
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :committees
  has_many :votes, dependent: :destroy
  has_many :favorites, as: :favoritable, dependent: :destroy
  has_many :followers, through: :favorites, source: :user
  has_many :positions, dependent: :destroy
  has_and_belongs_to_many :posts

  # Attributes
  enum feature_state: %i[unfeatured featured highlighted]
  attr_accessor :component # for click to edit feature

  # Scopes
  scope :special, -> { where(feature_state: %i[featured highlighted]).order('feature_position asc') }
  scope :visible, -> { where(is_visible: true) }
  scope :ordered, -> { order('introduced_on desc') }

  # Validations
  validates :number, uniqueness: { case_sensitive: false, scope: :congress_id }
  validates :title, presence: true
  validates :banner, blob: { content_type: :image }

  # Callbacks
  before_validation :sanitize_number
  # before_save :send_notifications

  # Class Methods
  def self.sync
    sync_started!

    data = ProPublica::Bills.new.recent.select(&:relevant?)

    data.each do |record|
      congress = Congress.where(number: record.congress).first_or_create
      bill     = congress.bills.where(number: record.number.delete('.')).first_or_initialize

      %w[number title summary full_text_url].each do |field|
        bill.send "#{field}=".to_sym, record.attributes[field.to_sym]
      end

      %w[introduced_on house_voted_on senate_voted_on enacted_on vetoed_on].each do |field|
        bill.send "#{field}=".to_sym, record.attributes[field.to_sym] if bill.send(field).nil?
      end

      bill.save!
      bill.send_notifications

      next unless bill.deep_scraped_on.blank?

      record.committee_bioguide_ids.each do |id|
        if committee = ::Committee.find_by(bioguide_id: id)
          bill.committees << committee
        end
      end

      record.tag_names.each do |name|
        bill.tags << ::Tag.where(name: name).first_or_create
      end

      bill.sponsor = ::Member.find_by(bioguide_id: record.sponsor_bioguide_id)

      if record.cosponsor_bioguide_ids.any?
        bill.cosponsor_ids = ::Member.where('bioguide_id IN (?)', record.cosponsor_bioguide_ids).pluck(:id)
      end

      bill.touch(:deep_scraped_on)
    end

    sync_completed!
  end

  # Methods
  def to_s
    number
  end

  def sync
    data = ProPublica::Bills.new.find(number.gsub(/\W/, ''))
    update!(data.attributes)
  end

  def primary_tag
    @primary_tag ||= tags.first
  end

  def state
    %w[intro house senate president].each_with_object({}) do |field, hash|
      hash[field.titleize] = send("#{field}_state")
    end
  end

  def intro_state
    'passed'
  end

  def house_state
    enacted_on? ? 'passed' : house_result
  end

  def senate_state
    enacted_on? ? 'passed' : senate_result
  end

  def president_state
    return 'passed' if enacted_on? && !vetoed_on?
    return 'failed' if !enacted_on? && vetoed_on?

    nil
  end

  def special?
    featured? || highlighted?
  end

  def all_sponsors
    @all_sponsors ||= User.find([])
  end

  def upvote_count
    @upvote_count ||= positions.where('position > 0').count
  end

  def downvote_count
    @downvote_count ||= positions.where('position < 0').count
  end

  def upvote_percentage
    return if positions.empty?

    @upvote_percentage ||= ((positions.where('position > 0').count / total_positions.to_f) * 100).round.to_s + '%'
  end

  def downvote_percentage
    return if positions.empty?

    @downvote_percentage ||= ((positions.where('position < 0').count / total_positions.to_f) * 100).round.to_s + '%'
  end

  def total_positions
    positions.where('position < 0').count + positions.where('position > 0').count
  end

  def house_vote_breakdown(position, party)
    votes.where(chamber_id: 1, position: position)
         .joins(:member).where('party = ?', party)
         .count
  end

  def senate_vote_breakdown(position, party)
    votes.where(chamber_id: 2, position: position)
         .joins(:member).where('party = ?', party)
         .count
  end

  def send_notifications
    { bill_house_change: 'house_result', bill_senate_change: 'senate_result',
      bill_enacted: 'enacted_on', bill_vetoed: 'vetoed_on' }.each do |kind, column|
      NotificationWorker.perform_in(30.seconds, kind, 'Bill', id) if changes.key?(column)
    end
  end

  private

  def sanitize_number
    return unless number

    self.number = number.delete('.')
  end
end

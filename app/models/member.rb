# frozen_string_literal: true

class Member < ApplicationRecord
  include PgSearch
  pg_search_scope :search, 
                  against: %i[name leadership_role], 
                  using: { tsearch: { prefix: true } }
  # Gems
  has_one_attached :photo
  # has_attached_file :photo, styles: { medium: '400x', thumb: '200x', square: '200x200#' }
  include SyncCache

  # Associations
  belongs_to :state
  belongs_to :chamber
  has_many :committee_memberships, dependent: :destroy
  has_many :committees, through: :committee_memberships
  has_many :sponsorships, dependent: :destroy
  has_many :bills, through: :sponsorships
  has_many :votes, dependent: :destroy
  has_many :favorites, as: :favoritable, dependent: :destroy
  has_many :followers, through: :favorites, source: :user
  has_many :media_videos, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # Scopes
  scope :in_office,      -> { where(in_office: true) }
  scope :senator,        -> { where(chamber: Chamber.find_by(name: 'Senate')) }
  scope :representative, -> { where(chamber: Chamber.find_by(name: 'House')) }
  scope :ordered,        -> { order('last_name asc, first_name asc') }

  # Attributes
  enum gender: %i[male female]

  # Validations
  validates :name, :first_name, :last_name, :bioguide_id, :chamber, :gender, presence: true
  validates :photo, blob: { content_type: :image }

  # Class Methods
  def self.sync
    sync_started!

    Chamber.find_each do |chamber|
      data = ProPublica::Members.new(chamber: chamber.name.downcase).all.select(&:in_office?)
      data.each do |record|
        member = where(bioguide_id: record.bioguide_id).first_or_initialize
        member.chamber = chamber
        member.update!(record.attributes.except(:photo_url, :in_office, :chamber))

        MediaVideo.sync(member)

        next unless member.photo.blank?

        begin
          member.photo = URI.parse(record.photo_url)
          member.save
        rescue StandardError; end
      end

      left_ids = in_office.where(chamber: chamber).pluck(:bioguide_id) - data.map(&:bioguide_id)
      left_ids.each do |id|
        find_by_bioguide_id(id).try(:out_of_office!)
      end
    end

    FacebookPhotoScraper.new.process if Rails.env.production?

    sync_completed!
  end

  # Methods
  def to_s
    name
  end

  def state_abbreviation=(abbreviation)
    self.state = State.find_by(abbreviation: abbreviation)
  end

  def state_abbreviation
    state.try(:abbreviation)
  end

  def out_of_office!
    update!(in_office: false)
  end

  def party_name
    {
      'R' => 'Republican',
      'D' => 'Democrat',
      'I' => 'Independent'
    }[party]
  end

  def party_and_state
    "[#{party}-#{state.abbreviation}]"
  end
end

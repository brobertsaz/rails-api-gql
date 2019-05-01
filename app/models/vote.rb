# frozen_string_literal: true

class Vote < ApplicationRecord
  # Gems
  include SyncCache

  # Associations
  belongs_to :chamber
  belongs_to :bill
  belongs_to :member

  # Attributes
  enum position: %i[yes no not_voting speaker present]

  # Scopes
  scope :without_speaker, -> { where('position != ?', positions[:speaker]) }
  scope :senate_votes_yes, -> { where(chamber_id: 1, position: 'yes') }
  scope :house_votes_yes, -> { where(chamber_id: 2, position: 'yes') }

  # Validations
  validates :position, presence: true

  # Callbacks
  after_create :send_notifications

  # Class Methods
  def self.sync
    sync_started!

    ProPublica::Votes.new.recent_passage_vote_urls.each do |url|
      data    = ProPublica::Votes.new.find(url)
      bill    = ::Bill.find_by!(number: data.bill.number.delete('.'))
      chamber = ::Chamber.find_by!('LOWER(name) = ?', data.chamber.downcase)

      data.positions.each do |position|
        member = ::Member.find_by!(bioguide_id: position.member_id)
        member.votes
              .where(bill: bill, chamber: chamber)
              .first_or_initialize
              .update!(position: position.vote_position.parameterize.underscore)
      end

      result = data.result.downcase.include?('passed') ? 'passed' : 'failed'
      bill.send("#{data.chamber.downcase}_result=", result)
      bill.sync
    end

    sync_completed!
  end

  private

  def send_notifications
    NotificationWorker.perform_in(5.seconds, :member_voted_bill, 'Vote', id)
  end
end

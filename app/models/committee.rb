# frozen_string_literal: true

class Committee < ApplicationRecord
  # Gems
  include SyncCache

  # Associations
  has_and_belongs_to_many :chambers
  has_and_belongs_to_many :bills
  has_many :committee_memberships
  has_many :members, through: :committee_memberships
  has_and_belongs_to_many :visible_bills, -> { where(is_visible: true) }, class_name: 'Bill'

  # Class Methods
  def self.sync
    sync_started!

    all_current_ids = []

    %w[senate house joint].each do |chamber|
      data = ProPublica::Committees.new(chamber: chamber).all
      data.each do |record|
        all_current_ids << record.bioguide_id

        committee = where(bioguide_id: record.bioguide_id).first_or_initialize
        committee.update!(name: record.name)

        chamber_records = if chamber == 'joint'
                            Chamber.all
                          else
                            Chamber.find_by!('LOWER(name) = ?', chamber)
                          end

        Array(chamber_records).each do |chamber_record|
          committee.chambers << chamber_record unless committee.chambers.include?(chamber_record)
        end

        record.members_with_roles.each do |member_id, role|
          member     = Member.find_by(bioguide_id: member_id)
          membership = committee.committee_memberships.where(member: member).first_or_initialize
          membership.update!(role: role)
        end

        committee.committee_memberships.joins(:member)
                 .where('members.bioguide_id NOT IN (?)', record.member_bioguide_ids)
                 .each(&:destroy)
      end
    end

    left_ids = Committee.pluck(:bioguide_id) - all_current_ids
    find(left_ids).map(&:destroy)

    sync_completed!
  end

  # Methods
  def to_s
    name
  end

  def kind
    @kind ||= chambers.many? ? 'Joint' : chambers.first.name
  end
end

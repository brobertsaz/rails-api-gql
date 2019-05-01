# frozen_string_literal: true

class CommitteeMembership < ApplicationRecord
  # Associations
  belongs_to :committee
  belongs_to :member

  # Validations
  validates :role, presence: true
end

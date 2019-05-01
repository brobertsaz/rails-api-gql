# frozen_string_literal: true

class AlertCategory < ApplicationRecord
  # Associations
  has_many :alerts, dependent: :nullify

  # Scopes
  scope :selectable, -> { where('id >= 3') }

  # Validations
  validates :name, presence: true
end

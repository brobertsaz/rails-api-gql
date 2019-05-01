# frozen_string_literal: true

class Congress < ApplicationRecord
  # Associations
  has_many :bills, dependent: :restrict_with_error

  # Validations
  validates :number, presence: true, uniqueness: true
end

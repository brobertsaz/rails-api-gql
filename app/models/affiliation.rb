# frozen_string_literal: true

class Affiliation < ApplicationRecord
  # Associations
  has_many :users

  # Validations
  validates :name, presence: true
end

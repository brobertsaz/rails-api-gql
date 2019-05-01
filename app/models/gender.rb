# frozen_string_literal: true

class Gender < ApplicationRecord
  # Associations
  has_many :users

  # Validations
  validates :name, presence: true
end

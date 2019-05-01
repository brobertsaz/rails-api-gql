# frozen_string_literal: true

class State < ApplicationRecord
  # Associations
  has_many :members
  has_many :users

  # Validations
  validates :abbreviation, :name, presence: true
  validates :abbreviation, uniqueness: { case_sensitive: false }

  # Methods
  def to_s
    name
  end
end

# frozen_string_literal: true

class Tag < ApplicationRecord
  # Associations
  has_and_belongs_to_many :bills

  # Validations
  validates :name, presence: true, uniqueness: true

  # Methods
  def to_s
    name
  end
end

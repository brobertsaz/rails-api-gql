# frozen_string_literal: true

class Chamber < ApplicationRecord
  # Associations
  has_many :members
  has_and_belongs_to_many :committees
  has_many :votes

  # Methods
  def to_s
    name
  end
end

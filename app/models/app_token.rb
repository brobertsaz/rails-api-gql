# frozen_string_literal: true

class AppToken < ApplicationRecord
  # Associations
  belongs_to :user

  # Attributes
  enum kind: %i[ios android]

  # Validations
  validates :kind, inclusion: { in: kinds.keys }

  # Callbacks
  before_create :set_token

  # Methods
  def set_token
    begin
      self.token = [SecureRandom.hex, SecureRandom.hex].join
    end while self.class.exists?(token: token)
  end
end

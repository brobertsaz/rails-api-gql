# frozen_string_literal: true

class ActionToken < ApplicationRecord
  # Associations
  belongs_to :user

  # Attributes
  enum kind: [:password_reset]

  # Callbacks
  before_create :set_token

  private

  def set_token
    begin
      self.token = SecureRandom.hex
    end while self.class.exists?(token: token)
  end
end

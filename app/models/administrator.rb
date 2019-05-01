# frozen_string_literal: true

class Administrator < ApplicationRecord
  # Gems
  has_secure_password

  # Validations
  validates :email, email: true, uniqueness: { case_sensitive: false }

  # Callbacks
  before_validation :downcase_email

  # Methods
  def to_s
    name
  end

  def first_name
    name.split(' ').first
  end

  def last_name
    name.split(' ').last
  end

  private

  def downcase_email
    email.try(:downcase!)
  end
end

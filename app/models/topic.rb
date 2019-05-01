# frozen_string_literal: true

class Topic < ApplicationRecord
  # Gems
  has_one_attached :image
  # has_attached_file :image, styles: { phone: '975x180#' }

  # Associations
  has_many :bills, dependent: :nullify
  has_many :posts, dependent: :nullify

  # Validations
  validates :name, :image, presence: true
  validates :image, blob: { content_type: :image }

  # Methods
  def to_s
    name
  end
end

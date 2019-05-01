# frozen_string_literal: true

class User < ApplicationRecord
  # Gems
  has_secure_password

  # Associations
  belongs_to :state, optional: true
  belongs_to :affiliation, optional: true
  belongs_to :gender, optional: true
  belongs_to :race, optional: true
  has_many :favorites, dependent: :destroy
  has_many :favorite_bills, through: :favorites, source: :favoritable, source_type: 'Bill'
  has_many :favorite_posts, through: :favorites, source: :favoritable, source_type: 'Post'
  has_many :favorite_members, through: :favorites, source: :favoritable, source_type: 'Member'
  has_many :action_tokens, dependent: :destroy
  has_many :positions, dependent: :destroy
  has_many :post_positions, dependent: :destroy
  has_many :app_tokens, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :visits, class_name: 'Ahoy::Visit'

  # Validations
  validates :name, :email, presence: true
  validates :email, email: true
  validates :email, uniqueness: { case_sensitive: false }
  validate  :validate_full_name
  validates :password, :password_confirmation, presence: true, on: :password_reset
  validates :affiliation, :race, :gender, presence: true, on: :demographic_update

  # Callbacks
  before_validation :downcase_email

  enum role: %i[standard ambassador]

  after_initialize do
    self.role ||= :standard if new_record?
  end

  # Methods
  def to_s
    name
  end

  def formatted_email
    "#{name} <#{email}>"
  end

  def first_name
    return nil if name.blank?

    array = name.split(' ')
    array.many? ? array[0..-2].join(' ') : array.first
  end

  def last_name
    return nil if name.blank?

    array = name.split(' ')
    array.many? ? array.last : nil
  end

  def included_alert_category_ids
    AlertCategory.pluck(:id) - excluded_alert_category_ids
  end

  def included_alert_category_ids=(ids)
    self.excluded_alert_category_ids = (AlertCategory.pluck(:id) - ids.select(&:present?).map(&:to_i))
  end

  def self.from_omniauth(auth)
    where(email: auth.info.email, provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.name = auth.info.name
      user.password = SecureRandom.hex
      user.save
    end
  end

  private

  def downcase_email
    self.email = email.try(:downcase)
  end

  def validate_full_name
    errors.add(:name, 'FULL name please') if name && (name.split(' ').size < 2)
  end
end

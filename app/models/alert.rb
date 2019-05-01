# frozen_string_literal: true

class Alert < ApplicationRecord
  # Associations
  belongs_to :alert_category

  # Validations
  validates :message, presence: true

  # Callbacks
  after_create :queue_blast

  # Methods
  def queue_blast
    AlertWorker.perform_in 5.seconds, id
  end

  def send_blast
    User.distinct.joins(:app_tokens).find_each do |user|
      PushNotifications::Alert.new(alert: self, user: user).push
    end
  end

  def category
    @category ||= (alert_category.name == 'Notable Daily Scopes' ? 'DAILY_SCOPE' : 'RANDOM')
  end
end

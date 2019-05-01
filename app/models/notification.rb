# frozen_string_literal: true

class Notification < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  # Attributes
  enum kind: %i[member_introduced_bill member_voted_bill bill_house_change
                bill_senate_change member_cosponsored_bill bill_enacted bill_vetoed]

  # Scopes
  scope :read,   -> { where(is_read: true) }
  scope :unread, -> { where(is_read: false) }

  # Callbacks
  after_create :send_push_notification

  # Class Methods
  def self.all_read_for(user)
    unread.where(user: user).update_all(is_read: true)
  end

  # Methods
  private

  def send_push_notification
    PushNotifications::Notification.new(self).push
  end
end

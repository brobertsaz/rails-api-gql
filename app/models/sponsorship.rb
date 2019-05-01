# frozen_string_literal: true

class Sponsorship < ApplicationRecord
  # Associations
  belongs_to :bill
  belongs_to :member

  # Attributes
  enum kind: %i[primary cosponsor]

  # Callbacks
  # after_create :send_notifications

  # Methods
  private

  def send_notifications
    kind = primary? ? :member_introduced_bill : :member_cosponsored_bill
    NotificationWorker.perform_in(5.seconds, kind, 'Sponsorship', id)
  end
end

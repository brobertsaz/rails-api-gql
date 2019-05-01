# frozen_string_literal: true

class NotificationWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(kind, klass, id)
    @kind     = kind
    @resource = klass.constantize.find(id)
    @users    = send(kind)
    create_notifications
  end

  def create_notifications
    @users.each do |user|
      Notification.create!(kind: @kind, user: user, notifiable: @resource)
    end
  end

  def member_introduced_bill
    @resource.member.followers
  end

  def member_voted_bill
    @resource.member.followers
  end

  def bill_house_change
    @resource.followers
  end

  def bill_senate_change
    @resource.followers
  end

  def member_cosponsored_bill
    @resource.member.followers
  end

  def bill_enacted
    @resource.followers
  end

  def bill_vetoed
    @resource.followers
  end
end

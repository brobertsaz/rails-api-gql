# frozen_string_literal: true

class AlertWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, backtrace: 20

  def perform(id)
    Alert.find(id).send_blast
  end
end

# frozen_string_literal: true

class SyncWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(klass_name)
    begin
      klass = klass_name.to_s.classify.constantize
    rescue NameError
      return
    end

    return unless klass.methods.include?(:syncing?)

    klass.sync
  end
end

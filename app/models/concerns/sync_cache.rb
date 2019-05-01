# frozen_string_literal: true

module SyncCache
  extend ActiveSupport::Concern

  class_methods do
    def sync_started!
      Rails.cache.write(sync_start_cache_key, Time.zone.now)
      Rails.cache.delete(sync_complete_cache_key)
      broadcast_sync_changes :started
    end

    def sync_completed!
      Rails.cache.write(sync_complete_cache_key, Time.zone.now)
      broadcast_sync_changes :completed
    end

    def last_synced_at
      Rails.cache.fetch(sync_complete_cache_key)
    end

    def syncing?
      started   = Rails.cache.fetch(sync_start_cache_key)
      completed = Rails.cache.fetch(sync_complete_cache_key)
      started.present? && completed.nil?
    end

    def sync_start_cache_key
      "#{name.underscore}_sync_started_at".to_sym
    end

    def sync_complete_cache_key
      "#{name.underscore}_sync_completed_at".to_sym
    end

    def broadcast_sync_changes(state)
      ActionCable.server.broadcast('sync_updates',
                                   id: name.underscore,
                                   state: state)
    rescue StandardError # swallow all exceptions
    end
  end
end

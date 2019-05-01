# frozen_string_literal: true

class MediaVideo < ApplicationRecord
  # Associations
  belongs_to :member

  # Scopes
  scope :visible, -> { where(is_visible: true) }

  # Validations
  validates :youtube_id, :name, presence: true

  # Class Methods
  def self.sync(member)
    return false if member.youtube.blank?

    channel = Yt::Channel.new(id: member.youtube)

    begin
      channel.public? # trigger a method
    rescue Yt::Errors::NoItems
      convertor = YoutubeIdConvertor.new(member)
      convertor.convert
      return false unless convertor.found?

      channel = Yt::Channel.new(id: member.reload.youtube)
    end

    channel.videos.first(3).each do |video|
      member.media_videos.where(youtube_id: video.id).first_or_initialize.update(name: video.title)
    end
  end

  # Methods
  def to_s
    name
  end
end

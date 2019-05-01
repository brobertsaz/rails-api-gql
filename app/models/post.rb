# frozen_string_literal: true

class Post < ApplicationRecord
  include PgSearch
  pg_search_scope :search, 
                  against: %i[body title], 
                  using: { tsearch: { prefix: true } }

  # Gems
  has_one_attached :image
  # has_attached_file :image, styles: { square: '300x300#' }

  # Associations
  has_and_belongs_to_many :bills
  has_many :post_positions, dependent: :destroy
  has_many :favorites, as: :favoritable, dependent: :destroy
  belongs_to :topic, optional: true

  # Attributes
  enum state: %i[draft published]
  enum kind: %i[post article video]

  # Scopes
  scope :actually_published, -> { where(state: :published).where('publish_at <= ?', Time.zone.now) }
  scope :ordered, -> { order('publish_at desc') }
  # Validations
  validates :title, :kind, :image, presence: true
  validates :publish_at, presence: true, if: :published?
  validates :body, presence: true, if: :post?
  validates :source, :url, presence: true, if: :article?
  validates :url, url: true, if: %i[article? video?]
  validate  :validate_youtube_url, if: :video?
  validates :image, blob: { content_type: :image }

  # ransacker :kind, formatter: proc { |v| kinds[v] }

  # Methods
  def status
    if actually_published?
      :published
    elsif published?
      :scheduled
    else
      :draft
    end
  end

  def actually_published?
    published? && publish_at <= Time.zone.now
  end

  def will_publish?
    published? && publish_at >= Time.zone.now
  end

  def youtube_id
    url.split('?v=').last if video?
  end

  def upvote_count
    @upvote_count ||= post_positions.where('position > 0').count
  end

  def downvote_count
    @downvote_count ||= post_positions.where('position < 0').count
  end

  private

  def validate_youtube_url
    errors.add(:url, 'Not a valid YouTube link') unless url&.starts_with?('https://www.youtube.com/watch?v=')
  end
end

class Article < ApplicationRecord
  extend FriendlyId
  include PgSearch
  friendly_id :title, use: :slugged
  mount_uploader :photo, ArticlePhotoUploader
  validates_presence_of :title, :description
  pg_search_scope :search_for, using: { tsearch: { prefix: true } }, against: %i(title description)
  def should_generate_new_friendly_id?
    title_changed?
  end
end

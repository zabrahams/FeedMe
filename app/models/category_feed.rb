class CategoryFeed < ActiveRecord::Base

  validates :feed_id, :category_id, presence: true
  validates :feed_id, uniqueness: { scope: :category_id }

  belongs_to :feed, inverse_of: :category_feeds
  belongs_to :category, inverse_of: :category_feeds 
end

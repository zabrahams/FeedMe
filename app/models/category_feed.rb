class CategoryFeed < ActiveRecord::Base

  validates :feed_id, :category_id, presence: true
  validates :feed_id, uniqueness: { scope: :category_id }

  belongs_to :feed
  belongs_to :category 
end

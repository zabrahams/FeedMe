class UserFeed < ActiveRecord::Base
  validates :user, :feed_id, presence: true
  validates :user, uniqueness: { scope: :feed_id }

  belongs_to :user, inverse_of: :user_feeds
  belongs_to :feed
end

class UserFeed < ActiveRecord::Base
  validates :user_id, :feed_id, presence: true
  validates :user_id, uniqueness: { scope: :feed_id }

  belongs_to :user
  belongs_to :feed
end

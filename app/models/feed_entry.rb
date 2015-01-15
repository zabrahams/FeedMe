class FeedEntry < ActiveRecord::Base
  validates :feed_id, :entry_id, presence: true
  validates :feed_id, uniqueness: {scope: :entry_id}

  belongs_to :feed
  belongs_to :entry

end

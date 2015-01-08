class Entry < ActiveRecord::Base

  validates :guid, :feed_id, :published_at, :json, presence: true
  validates :guid, uniqueness: true

  belongs_to :feed

end

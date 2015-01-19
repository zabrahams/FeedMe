class Entry < ActiveRecord::Base

  validates :guid, :published_at, :json, presence: true
  validates :guid, uniqueness: true

  has_many :feed_entries
  has_many :feeds, through: :feed_entries, source: :feed
  has_many :user_read_entries, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy



end

class Feed < ActiveRecord::Base
  include Feedjira

  validates :name, :url, presence: true
  validates :name, :url, uniqueness: true

  has_many :user_feeds, dependent: :destroy
  has_many :users, through: :user_feeds
  has_many :entries, dependent: :destroy

  attr_accessor :feed

  def set_url=(url)
    self.url = url
    self.feed = Feedjira::Feed.fetch_and_parse(url)
    self.name = self.feed.title
  end

end

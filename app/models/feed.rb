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
    entries = self.feed.entries.map do |entry|
      {
        guid: entry.entry_id,
        title: entry.title,
        link: entry.url,
        published_at: entry.published,
        json: entry.to_json
      }
    end
    self.save && self.entries.create(entries)
  end

  def update_entries!
    currEntries = Feedjira::Feed.fetch_and_parse(self.url).entries
    currEntries = currEntries[0...40] if currEntries.length > 40
    oldest = currEntries.last

    self.entries.where("published_at < ?", oldest.published).delete_all

    newEntries = currEntries.select do |currEntry|
      currEntry.published > self.updated_at
    end

    newEntries = newEntries.map do |entry|
      {
        guid: entry.entry_id,
        title: entry.title,
        link: entry.url,
        published_at: entry.published,
        json: entry.to_json
      }
    end
    
    self.entries.create(newEntries)
    self.touch
  end

end

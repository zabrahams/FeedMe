class Feed < ActiveRecord::Base
  include Feedjira

  validates :name, :url, presence: true
  validates :name, :url, uniqueness: true
  validate :url_must_lead_to_rss_feed

  has_many :user_feeds, dependent: :destroy
  has_many :users, through: :user_feeds
  has_many :entries, inverse_of: :feed, dependent: :destroy
  has_many :category_feeds, inverse_of: :feed, dependent: :destroy
  has_many :categories, through: :category_feeds

  before_validation :set_name, on: :create
  after_save :fetch_entries, on: :create

  attr_accessor :feed

  def set_name
    self.feed || self.feed = Feedjira::Feed.fetch_and_parse(self.url)
    unless feed == 200 # Feedjira::Feed.fetch_and_parse returns 200 on failure
      self.name = self.feed.title
    end
  end

  def fetch_entries
    self.feed || self.feed = Feedjira::Feed.fetch_and_parse(self.url)

    new_entries = self.feed.entries
    new_entries = new_entries[0...40] if new_entries.length > 40

    new_entries = new_entries.map do |entry|
      {
        guid: entry.entry_id,
        title: entry.title,
        link: entry.url,
        published_at: entry.published,
        json: entry.to_json
      }
    end

    self.entries.create(new_entries)
  end

  def update_entries
    update_entries! if self.updated_at < 1.minutes.ago
  end


  # Potential optimization for the future:
  # Seperate feeds into two categories based on popularity.
  # Popular feeds (maybes ones followed by x number of users)
  # are updated every n-minutes by a scheduled process. Less
  # popular feeds are updated using update_entries when there is a need
  # for them. For now I'm just updated everything as used.
  def update_entries!
    self.feed || self.feed = Feedjira::Feed.fetch_and_parse(self.url)
    curr_entries = self.feed.entries
    curr_entries = curr_entries[0...40] if curr_entries.length > 40
    oldest = curr_entries.last

    # Delete would reduce queries, but I'd need to manually need to delete the
    # dependent user_read_entries
    self.entries.where("published_at < ?", oldest.published).destroy_all

    new_entries = curr_entries.select do |curr_entry|
      curr_entry.published > self.updated_at
    end

    new_entries = new_entries.map do |entry|
      {
        guid: entry.entry_id,
        title: entry.title,
        link: entry.url,
        published_at: entry.published,
        json: entry.to_json
      }
    end

    self.entries.create(new_entries)
    self.touch
  end

  private

  def url_must_lead_to_rss_feed
    self.feed || self.feed = Feedjira::Feed.fetch_and_parse(self.url)
    if self.feed == 200
      errors.add(:url, "Url is not the location of an RSS feed.")
    end
  end

  def update_entries
    # Should I set a condition to limit how often a feed can reload?
    self.feed = Feedjira::Feed.fetch_and_parse(self.url)
    newest = feed.entries.first.published
    oldest = feed.entries.last.published
    self.entries.where("published_at < ?", oldest).delete_all
    entries = self.feed.entries.map do |entry|
      {
        guid: entry.entry_id,
        title: entry.title,
        link: entry.url,
        published_at: entry.published,
        json: entry.to_json
      }
    end
  self.entries.create(entries)
  end

end

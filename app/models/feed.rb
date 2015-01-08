class Feed < ActiveRecord::Base
  include Feedjira

  validates :name, :url, presence: true
  validates :name, :url, uniqueness: true

  has_many :user_feeds, dependent: :destroy
  has_many :users, through: :user_feeds
  has_many :entries, dependent: :destroy
  has_many :category_feeds, dependent: :destroy
  has_many :categories, through: :category_feeds

  attr_accessor :feed

  def set_url=(url)
    self.url = url
    feed = Feedjira::Feed.fetch_and_parse(self.url)
    self.name = feed.title
    self.save

    new_entries = Feedjira::Feed.fetch_and_parse(self.url).entries
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

    # I should maybe self.touch here.  There's a slight possibility that I'll
    # duplicate an entry if it is posted between the save and the fetch
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
    curr_entries = Feedjira::Feed.fetch_and_parse(self.url).entries
    curr_entries = curr_entries[0...40] if curr_entries.length > 40
    oldest = curr_entries.last

    self.entries.where("published_at < ?", oldest.published).delete_all

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

end

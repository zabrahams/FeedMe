class Feed < ActiveRecord::Base
  include Feedjira

  validates :url, presence: true
  validates :name, uniqueness: true
  validate :url_must_lead_to_rss_feed

  has_many :user_feeds, dependent: :destroy
  has_many :users, through: :user_feeds

  has_many :feed_entries, dependent: :destroy
  has_many :entries, through: :feed_entries, source: :entry

  has_many :category_feeds, inverse_of: :feed, dependent: :destroy
  has_many :categories, through: :category_feeds
  belongs_to :curator, class_name: "User", foreign_key: "curator_id"

  before_validation :set_name_and_url, on: :create
  after_save :fetch_entries, on: :create
  before_destroy :destroy_entries_unless_curated

  attr_accessor :feed

  def self.find_scrape_or_create(url)
    return_feed = self.find_by(url: url)
    unless return_feed
      return_feed = self.find_by(url: self.scrape_page_for_rss_url(url))
    end
    unless return_feed
      return_feed = self.create(url: url)
    end

    return_feed
  end


  # TODO: change this, because the external requests shouldn't be called as part of the feeds create controller action


  def self.scrape_page_for_rss_url(given_url)
    begin
      url = (given_url[0..3] == "http" ? given_url : "http://#{given_url}")
      html_doc = Nokogiri.HTML(open(url))
    rescue Errno::ENOENT
      return 404
    end

    rss_tag = html_doc.css("link[type='application/rss+xml']").first
    return nil if rss_tag.nil?
    rss_url = rss_tag.attributes['href'].value
    rss_url = "#{given_url}#{rss_url}" if rss_url[0] == "/"
    rss_url
  end

  def set_name_and_url
    unless self.curated
      self.feed || self.feed = Feedjira::Feed.fetch_and_parse(self.url)

      # TODO: Harden this to account for nil urls
      if feed.is_a?(Fixnum) # Feedjira::Feed.fetch_and_parse returns a status code on failure

        rss_url = ActiveRecord::Base::Feed.scrape_page_for_rss_url(self.url)
        return rss_url if rss_url.nil? || rss_url.is_a?(Fixnum)

        self.feed = Feedjira::Feed.fetch_and_parse(rss_url)
        return feed if feed.is_a?(Fixnum)

        self.url = rss_url
      end

      self.name = self.feed.title
    end
  end

  def fetch_entries
    if self.curated
      self.entries == self.curator.read_entries
    else
      self.feed || self.feed = Feedjira::Feed.fetch_and_parse(self.url)

      new_entries = self.feed.entries
      new_entries = new_entries[0...40] if new_entries.length > 40

      new_entries = new_entries.map do |entry|
        {
          guid: entry.entry_id || SecureRandom.urlsafe_base64,
          title: entry.title,
          link: entry.url,
          published_at: entry.published || Time.now,
          json: entry_to_json(entry)
        }
      end

    self.entries.create(new_entries)
    # saved_entries = new_entries.map { |entry| Entry.create(entry) }
    # saved_entries.escrape_url_for_rss_urlach { |saved_entry| self.entries << saved_entry }
    end
  end

  # Potential optimization for the future:
  # Seperate feeds into two categories based on popularity.
  # Popular feeds (maybes ones followed by x number of users)
  # are updated every n-minutes by a scheduled process. Less
  # popular feeds are updated using update_entries when there is a need
  # for them. For now I'm just updated everything as used.
  def need_update?
    self.updated_at < 3.minutes.ago
  end

  def update_entries
    if self.entries == []
      self.fetch_entries
      self.touch
    else
      self.feed || self.feed = Feedjira::Feed.fetch_and_parse(self.url)
      return nil if self.feed.is_a?(Fixnum) || self.feed == {}
      curr_entries = self.feed.entries
      curr_entries = curr_entries[0...40] if curr_entries.length > 40
      oldest = curr_entries.last

      # Delete would reduce queries, but I'd need to manually need to delete the
      # dependent user_read_entries
      self.entries
        .where("published_at < ?", 1.month.ago)
        .each { |entry| entry.destroy }

      puts "remainder"
      puts self.entries

      new_entries = curr_entries.select do |curr_entry|
        !curr_entry.published || curr_entry.published > self.updated_at
      end

      puts "new_entries"
      puts new_entries

      new_entries = new_entries.map do |entry|
        {
          guid: entry.entry_id || SecureRandom.urlsafe_base64,
          title: entry.title,
          link: entry.url,
          published_at: (entry.published || Time.now) ,
          json: entry_to_json(entry)
        }
      end
      self.entries.create(new_entries)
      self.touch;
    end


  end

  private

  def url_must_lead_to_rss_feed
    unless self.curated
      self.feed || self.feed = Feedjira::Feed.fetch_and_parse(self.url)
      if self.feed.is_a?(Fixnum)
        errors.add(:url, " is not the location of an RSS feed.")
      end
    end
  end

  def entry_to_json(entry)
    convertable_entry = {}
    properties = %w(title summary content author url entry_id published)

    properties.each do |property|
      convertable_entry[property] = entry[property]
    end

    convertable_entry.to_json
  end

  def destroy_entries_unless_curated
    self.entries.each { |entry| entry.destroy } unless self.curated
  end

end

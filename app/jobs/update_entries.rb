class UpdateEntries
  @queue = :update_rss

  def self.perform(feed_id)
    feed = Feed.find(feed_id)
    feed.update_entries
  end

end

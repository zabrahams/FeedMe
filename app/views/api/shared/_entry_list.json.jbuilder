json.array! entries do |entry|
  json.partial! 'api/entries/single_entry', entry: entry

  feed = entry.feeds.find { |feed| feed.curated && current_user.feeds.include?(feed) }
  feed ||=  entry.feeds.find { |feed| current_user.feeds.include?(feed) }

  json.feed_name feed.name
  json.feed_id feed.id
end

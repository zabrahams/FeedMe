json.array! entries do |entry|
  json.partial! 'api/entries/single_entry', entry: entry
  json.feed_name entry.feeds.select { |feed| !feed.curated }.first.name
  json.feed_id entry.feeds.select { |feed| !feed.curated }.first.id
end

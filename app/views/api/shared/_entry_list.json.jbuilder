json.array! entries do |entry|
  json.partial! 'api/entries/single_entry', entry: entry
  json.feed_name entry.feed.name
  json.feed_id entry.feed.id
end

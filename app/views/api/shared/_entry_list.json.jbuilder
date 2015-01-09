json.array! entries do |entry|
  json.extract! entry, :id, :title, :published_at
  json.feed entry.feed.name
end

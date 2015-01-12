json.id @category.id
json.name @category.name

json.entries do
  json.partial! 'api/shared/entry_list', entries: @entries
end

if @category.feeds.any? { |feed| feed.updated_at > 30.seconds.ago }
  json.updating false
else
  json.updating true
end

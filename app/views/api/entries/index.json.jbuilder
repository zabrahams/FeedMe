json.entries do
  json.partial! 'api/shared/entry_list', entries: @entries
end

if @feeds.any? { |feed| feed.updated_at > 30.seconds.ago }
  json.updating false
else
  json.updating true
end

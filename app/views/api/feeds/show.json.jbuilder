json.extract! @feed, :name

json.entries do
  json.partial! 'api/shared/entry_list', entries: @entries
end

if @feed.need_update?
  json.updating true
else
  json.updating false
end

json.updated_at @feed.updated_at

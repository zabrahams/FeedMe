json.id @category.id
json.name @category.name

json.entries do
  json.partial! 'api/shared/entry_list', entries: @entries
end

if @category.feeds.any? { |feed| feed.need_update? }
  json.updating false
else
  json.updating true
end

json.extract! @feed, :name

json.entries do
  json.partial! 'api/shared/entry_list', entries: @entries
end

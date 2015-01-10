json.id @category.id
json.name @category.name

json.entries do
  json.partial! 'api/shared/entry_list', entries: @entries
end

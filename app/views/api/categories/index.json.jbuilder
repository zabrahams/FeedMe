json.array! @categories do |category|
  json.extract! category, :id, :name
  json.feeds category.feeds do |feed|
    json.id feed.id
    json.name feed.name
  end
end

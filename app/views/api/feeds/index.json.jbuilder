json.array! @feeds do |feed|
  json.extract! feed, :name, :id
end

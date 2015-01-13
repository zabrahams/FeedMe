json.array! @users do |user|
  json.extract! user, :id, :username, :fname, :lname, :description
  json.image_url asset_path(user.image.url)
end

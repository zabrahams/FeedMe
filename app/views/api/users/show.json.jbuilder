json.extract! @user, :id, :username, :fname, :lname, :description, :email
json.image_url asset_path(@user.image.url)

json.curators @user.curators do |curator|
  json.extract! curator, :id, :username
end

json.watchers @user.watchers do |watcher|
  json.extract! watcher, :id, :username
end

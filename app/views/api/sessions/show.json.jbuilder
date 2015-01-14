json.extract! @user, :id, :username, :fname, :lname, :description, :email
json.image_url asset_path(@user.image.url)

json.errors @user.errors.full_messages if @user.errors
json.username @user.username if @user.username
json.email @user.email if @user.email

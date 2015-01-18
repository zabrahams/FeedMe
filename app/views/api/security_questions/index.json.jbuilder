if @user
  json.questions @questions do |question|
    json.extract! question, :id, :content
  end
   json.user_id @user.id
else
  json.array! @questions do |question|
    json.extract! question, :id, :content
  end
end

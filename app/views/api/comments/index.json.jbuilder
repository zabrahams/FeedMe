json.array! @comments do |comment|
  json.extract! comment, :body, :id, :created_at
  json.author comment.author.username
end

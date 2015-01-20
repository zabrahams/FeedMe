json.array! @comments do |comment|
  json.extract! comment, :body, :id, :created_at, :commentable_type, :commentable_id
  json.author comment.author.username
end

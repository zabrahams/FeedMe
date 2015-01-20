class Comment < ActiveRecord::Base

  validates :body, :author_id, :commentable_id, :commentable_type, presence: true

  belongs_to :imageable, polymorphic: true
  belongs_to :author,
             class_name: "User",
             foreign_key: :author_id

  def is_by?(user)
    author_id === user.id
  end

  def is_about?(user)
    self.commentable_type === "User" &&
    self.commentable_id === user.id
  end

end

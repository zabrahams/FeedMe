class UserFollow < ActiveRecord::Base
  validates :followed_id, :following_id, presence: true;
  validates :followed_id, uniqueness: { scope: :following_id }

  belongs_to :followed, class_name: "User", foreign_key: :followed_id
  belongs_to :following, class_name: "User", foreign_key: :following_id


end

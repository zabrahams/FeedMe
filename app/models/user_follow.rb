class UserFollow < ActiveRecord::Base
  validates :watcher_id, :curator_id, presence: true;
  validates :watcher_id, uniqueness: { scope: :curator_id }

  belongs_to :watcher, class_name: "User", foreign_key: :watcher_id
  belongs_to :curator, class_name: "User", foreign_key: :curator_id


end

class UserReadEntry < ActiveRecord::Base
  validates :user_id, :entry_id, presence: true
  validates :user_id, uniqueness: { scope: :entry_id }

  belongs_to :user
  belongs_to :entry

end

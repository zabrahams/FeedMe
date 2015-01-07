class Feed < ActiveRecord::Base
  validates :name, :url, presence: true
  validates :name, :url, uniqueness: true

  has_many :user_feeds, dependent: :destroy
  has_many :users, through: :user_feeds
end

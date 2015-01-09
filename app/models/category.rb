class Category < ActiveRecord::Base

  validates :name, :user_id, presence: true
  validates :name, uniqueness: { scope: :user_id }

  belongs_to :user
  has_many :category_feeds, inverse_of: :category, dependent: :destroy
  has_many :feeds, through: :category_feeds
  has_many :entries, through: :feeds

end

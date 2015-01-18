class SecurityQuestion < ActiveRecord::Base
  validates :content, presence: true, uniqueness: true

  has_many :answers, foreign_key: :question_id
end

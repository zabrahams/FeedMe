class SecurityQuestionAnswer < ActiveRecord::Base
  validates :answer_digest, :user, :question_id, presence: true
  validates :user, uniqueness: { scope: :question_id }

  belongs_to :security_question, foreign_key: :question_id
  belongs_to :user

  attr_reader :answer

  def answer=(answer)
    self.answer_digest = BCrypt::Password.create(answer)
  end

  def correctAnswer?(attempt)
    BCrypt::Password.new(self.answer_digest).is_password?(attempt)
  end

end

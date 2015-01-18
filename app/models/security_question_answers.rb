class SecurityQuestionAnswers < ActiveRecord::Base
  validates :answer_digest, :user_id, :question_id, presence: true
  validates :user_id, uniqueness: { scope: :question_id }

  belongs_to :security_question
  belongs_to :user

  attr_reader :answer

  def answer=(answer)
    self.answer_digest = BCrypt::Password.create(answer)
  end

  def correctAnswer?(attempt)
    BCrypt::Password.new(self.answer_digest).is_password?(attempt)
  end
end

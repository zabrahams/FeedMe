require 'rails_helper'

RSpec.describe SecurityQuestionAnswer do
  subject { FactoryGirl.build(:security_question_answer) }

  it { should validate_presence_of(:answer_digest)}
  it { should validate_presence_of(:question_id)}
  it { should validate_presence_of(:user)}

  it { should validate_uniqueness_of(:user_id).scoped_to(:question_id)}

  it { should belong_to(:security_question)
    .with_foreign_key(:question_id)}
  it { should belong_to(:user) }

  describe "SecurityQuestionAnswer#answer=" do

    it "sets answer_digest"

  end

  describe "SecurityQuestionAnswer#correct_answer?" do

    it "returns true if attempt hashes to answer_digest"

    it "returns false if attempt doesn't hash to answer_digest"

  end

end

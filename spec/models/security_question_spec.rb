require 'rails_helper'

RSpec.describe SecurityQuestion do
  subject { FactoryGirl.build(:security_question) }

  it { should validate_presence_of(:content) }
  it { should validate_uniqueness_of(:content) }

  it { should have_many(:answers)
    .class_name(:"SecurityQuestionAnswer")
    .with_foreign_key(:question_id) }

end

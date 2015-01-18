require 'rails_helper'

RSpec.describe User do
  subject { FactoryGirl.build(:user) }

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }


  it { should validate_uniqueness_of(:username) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:session_token) }

  it { should have_many(:watcher_user_follows) }
  it { should have_many(:curator_user_follows) }
  it { should have_many(:watchers) }
  it { should have_many(:curators) }

  it { should have_many(:user_feeds) }
  it { should have_many(:feeds) }
  it { should have_many(:categories) }
  it { should have_many(:user_read_entries) }
  it { should have_many(:read_entries) }

  it { should have_many(:security_question_answers)
      .inverse_of(:user)
      .dependent(:destroy)}
  it { should have_many(:security_questions) }

end

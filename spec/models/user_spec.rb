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

  it { should have_many(:user_feeds) }
  it { should have_many(:feeds) }
  it { should have_many(:categories) }

end

require 'rails_helper'

RSpec.describe UserFeed do

  subject { FactoryGirl.build(:user_feed) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:feed_id) }

  it { should validate_uniqueness_of(:user_id).scoped_to(:feed_id) }

  it { should belong_to(:user) }
  it { should belong_to(:feed) }
end

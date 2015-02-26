require 'rails_helper'

RSpec.describe UserFollow do

  subject { FactoryGirl.build(:user_follow) }

  it { should validate_presence_of(:watcher_id) }
  it { should validate_presence_of(:curator_id) }

  it { should validate_uniqueness_of(:watcher_id).scoped_to(:curator_id) }

  it { should belong_to(:watcher) }
  it { should belong_to(:curator) }
end

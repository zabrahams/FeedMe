require 'rails_helper'

RSpec.describe Category do
  subject { FactoryGirl.build(:category) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user_id) }

  it { should validate_uniqueness_of(:name).scoped_to(:user_id) }

  it { should belong_to(:user) }
  it { should have_many(:category_feeds) }
  it { should have_many(:feeds) }
end

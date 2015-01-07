require 'rails_helper'

RSpec.describe Feed do
  subject { FactoryGirl.build(:feed) }


  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:url) }

  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:url) }

  it { should have_many(:user_feeds) }
  it { should have_many(:users) }

end

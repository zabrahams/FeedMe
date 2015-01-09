require 'rails_helper'

RSpec.describe CategoryFeed do
  subject { FactoryGirl.build(:category_feed) }

  it { should validate_presence_of(:feed_id) }
  it { should validate_presence_of(:category_id) }

  it { should validate_uniqueness_of(:feed_id).scoped_to(:category_id) }

  it { should belong_to(:feed) }
  it { should belong_to(:category) }
end

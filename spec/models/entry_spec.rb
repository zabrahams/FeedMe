require 'rails_helper'

RSpec.describe Entry do
  subject { FactoryGirl.build(:entry) }

  it { should validate_presence_of(:guid) }
  it { should validate_presence_of(:published_at) }
  it { should validate_presence_of(:json) }

  it { should validate_uniqueness_of(:guid) }
  it { should have_many(:user_read_entries) }

end

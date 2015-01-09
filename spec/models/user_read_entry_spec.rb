require 'rails_helper'

RSpec.describe UserReadEntry do
  subject { FactoryGirl.build(:user_read_entry) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:entry_id) }

  it { should validate_uniqueness_of(:user_id).scoped_to(:entry_id) }

  it { should belong_to(:user) }
  it { should belong_to(:entry) }

end

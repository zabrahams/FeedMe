require 'rails_helper'

RSpec.describe Comment do
  subject { FactoryGirl.build(:feed_entry) }

  it { should validate_presence_of(:feed_id)}
  it { should validate_presence_of(:entry_id)}
  it { should validate_uniqueness_of(:feed_id).scoped_to(:entry_id)}

  it { should belong_to(:feed) }
  it { should belong_to(:entry) }

end

FactoryGirl.define do
  factory :feed_entry do
    feed_id { rand(500) }
    entry_id { rand(500) }
  end
end

FactoryGirl.define do
  factory :user_feed do
    user_id { rand(500) }
    feed_id { rand(500) }
  end

end

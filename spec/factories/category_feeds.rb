FactoryGirl.define do
  factory :category_feed do
    feed_id { rand(50) }
    category_id { rand(50) }
  end
end

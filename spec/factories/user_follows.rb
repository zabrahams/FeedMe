FactoryGirl.define do
  factory :user_follow do
    watcher_id { rand(500) }
    curator_id { rand(500) }
  end
  
end

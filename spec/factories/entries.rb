FactoryGirl.define do
  factory :entry do
    guid { SecureRandom.urlsafe_base64 }
    title { Faker::Lorem.sentence }
    link { Faker::Internet.url }
    published_at Time.now
    json '{"author": "Test T"}'
  end

end

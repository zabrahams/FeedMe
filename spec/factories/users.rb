FactoryGirl.define do
  factory :user do
    username "John"
    email "John@example.com"
    password "123456"
    activated true
    activation_token "token"
  end
end

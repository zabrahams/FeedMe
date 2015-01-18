FactoryGirl.define do
  factory :user do
    username "John"
    email "John@example.com"
    password "1234560"
    activated true
    activation_token "token"
  end
end

FactoryGirl.define do
  factory :entry do
    guid "I'm so unique"
    title "the best title"
    link "www.awesomesauce.com"
    published_at Time.now
    json "'content':'cool stuff'"
  end

end

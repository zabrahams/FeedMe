# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

test_user = User.create(username: 'test', email: 'test@example.com', password: '123456', activated: true)

users = []
10.times do
  users << User.create(
    username:    Faker::Internet.user_name,
    email:       Faker::Internet.email,
    password:    "123456",
    image:       Faker::Avatar.image,
    fname:       Faker::Name.first_name,
    lname:       Faker::Name.last_name,
    description: Faker::Company.bs                       )
end

feed1 = Feed.create(url: "http://feeds.feedburner.com/Metafilter")
feed2 = Feed.create( url: "http://feeds.feedburner.com/AskMetafilter")
feed3 = Feed.create( url: "http://feeds.mashable.com/Mashable")
feed4 = Feed.create( url: "http://www.polygon.com/rss/index.xml")
feed5 = Feed.create( url: "http://lorem-rss.herokuapp.com/feed/?unit=minute&interval=5" )
feed6 = Feed.create( url: "http://lorem-rss.herokuapp.com/feed/?unit=second&interval=10")
feed7 = Feed.create( url: "http://feeds.theonion.com/theonion/daily")
feed8 = Feed.create( url: "http://feeds.arstechnica.com/arstechnica/index/")
feed9 = Feed.create( url: "http://bbcsherlockftw.tumblr.com/rss")
feed10 = Feed.create( url: "http://languagelog.ldc.upenn.edu/nll/?feed=rss2")
feed11 = Feed.create( url: "http://feeds.poetryfoundation.org/HarrietTheBlog")
feed12 = Feed.create( url: "https://hacks.mozilla.org/feed/")


test_user.feeds << feed3
test_user.feeds << feed4
test_user.feeds << feed5
test_user.feeds << feed6
test_user.feeds << feed7
test_user.feeds << feed8


users.first.feeds << feed12
users.first.feeds << feed11
users.first.feeds << feed10
users.first.feeds << feed9

users.last.feeds << feed1
users.last.feeds << feed2
users.last.feeds << feed7
users.last.feeds << feed8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create(username: 'z', email: 'z@z.z', password: '123456')


feed1 = Feed.create(url: "http://feeds.feedburner.com/Metafilter")
feed2 = Feed.create( url: "http://feeds.feedburner.com/AskMetafilter")
feed3 = Feed.create( url: "http://feeds.mashable.com/Mashable")
feed4 = Feed.create( url: "http://www.polygon.com/rss/index.xml")
feed5 = Feed.create( url: "http://lorem-rss.herokuapp.com/feed/?unit=minute&interval=5" )
feed6 = Feed.create( url: "http://lorem-rss.herokuapp.com/feed/?unit=second&interval=10")


user1.feeds << feed3
user1.feeds << feed4
user1.feeds << feed5
user1.feeds << feed6

user1.categories.create([
    { name: "Tech", feed_ids: [feed3.id, feed4.id]},
    { name: "Latin", feed_ids: [feed5.id, feed6.id]}
])

user2 = User.create(username: 'mefi', email: 'mefi@example.com', password: '123456')


user2.feeds << feed1
user2.feeds << feed2

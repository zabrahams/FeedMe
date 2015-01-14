# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(username: 'z', email: 'z@z.z', password: '123456')

user.feeds.create([
    { url: "http://feeds.feedburner.com/Metafilter" },
    { url: "http://feeds.feedburner.com/AskMetafilter" },
    { url: "http://feeds.mashable.com/Mashable" },
    { url: "http://www.polygon.com/rss/index.xml" },
    { url: "http://lorem-rss.herokuapp.com/feed/?unit=minute&interval=5" },
    { url: "http://lorem-rss.herokuapp.com/feed/?unit=second&interval=10" }
])

user.categories.create([
    { name: "Tech", feed_ids: [3, 4]},
    { name: "Latin", feed_ids: [5]}
])

FeedMe.Collections.RecentlyRead = Backbone.Collection.extend({

  model: FeedMe.Models.Entry,

  comparator: "published_at",

  url: "/api/entries/recent"
})

FeedMe.Collections.Entries = Backbone.Collection.extend({

  model: FeedMe.Models.Entry,

  comparator: "published_at",

  url: "/api/entries"
})

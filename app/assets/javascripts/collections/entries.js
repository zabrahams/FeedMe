FeedMe.Collections.Entries = Backbone.Collection.extend({

  model: FeedMe.Models.Entry,

  url: "/api/entries"
})

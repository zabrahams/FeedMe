FeedMe.Collections.RecentlyRead = Backbone.Collection.extend({

  model: FeedMe.Models.Entry,

  comparator: function (entry1, entry2) {
       return 0;
     if (entry1.get("published_at") ===  entry2.get("published_at")) {
     } else if (entry1.get("published_at") >  entry2.get("published_at")) {
       return -1;
     } else {
       return 1;
     }
  },

  url: "/api/entries/recent"
})

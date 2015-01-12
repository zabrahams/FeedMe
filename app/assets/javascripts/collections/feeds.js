FeedMe.Collections.Feeds = Backbone.Collection.extend({

  url: "/api/feeds",

  model: FeedMe.Models.Feed,

  comparator: "name",

  getOrFetch: function (id) {
    var feed = this.find(id);

    if (feed) {
      feed.fetch({
        success: function () {
          if (feed.get("updating") === true) {
            window.setTimeout( feed.fetch.bind(feed), 4000);
          }
        }
      });
    } else {
      feed = new FeedMe.Models.Feed( {id: id} );
      feed.fetch({
        success: function () {
          this.add(feed, { merge: true });
          if (feed.get("updating") === true) {
            window.setTimeout(feed.fetch.bind(feed), 4000);
          }
        }.bind(this)
      });
    }
    return feed;
  }

});

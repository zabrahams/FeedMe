FeedMe.Collections.Categories = Backbone.Collection.extend({

  model: FeedMe.Models.Category,

  url: "/api/categories",

  getOrFetch: function (id) {
    var feed = this.find(id);

    if (feed) {
      feed.fetch();
    } else {
      feed = new FeedMe.Models.Feed( {id: id} );
      feed.fetch({
        success: function () {
          this.add(feed, { merge: true });
        }.bind(this)
      });
    }
    return feed
  }

});

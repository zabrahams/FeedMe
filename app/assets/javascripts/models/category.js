FeedMe.Models.Category = Backbone.Model.extend({

  urlRoot: "/api/categories",

  entries: function () {
    this._entries = this._entries || new FeedMe.Collections.Entries();
    return this._entries;
  },

  feeds: function () {
    this._feeds = this._feeds || new FeedMe.Collections.Feeds();
    return this._feeds;
  },

  parse: function (resp) {
    var entries;

    if (resp.entries) {
      this.entries().set(resp.entries);
      delete resp.entries
    }

    if (resp.feeds) {
      this.feeds().set(resp.feeds);
      delete resp.feeds
    }

    return resp;
  },

  toJSON: function () {
    var feedIds, attrs;
    attrs = _.clone(this.attributes);

    if (this._feeds) {
      feedIds = this.feeds().map(function (feed) {
        return feed.id;
      });
      attrs.feed_ids = feedIds;
    }

    return {"category": attrs};
  }

});

FeedMe.Models.Category = Backbone.Model.extend({

  initialize: function () {
    this.update_limit = 0;
  },

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
      delete resp.entries;
    }

    if (resp.feeds) {
      this.feeds().set(resp.feeds);
      delete resp.feeds;
    }

    if (resp.updating) {
      console.log(resp.updating);
      console.log(resp.updated_at);
      console.log(resp.name);
      if (resp.updating === true && this.update_limit < 2) {
        window.setTimeout( this.fetch.bind(this), Constants.UPDATING_TIMEOUT);
      } else if (resp.updating === false) {
        this.update_limit = 0;
      }
      
      delete resp.updating;
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

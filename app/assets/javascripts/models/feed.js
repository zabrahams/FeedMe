FeedMe.Models.Feed = Backbone.Model.extend({

  initialize: function () {
    this.update_limit = 0
  },

  urlRoot: "/api/feeds",

  entries: function () {
    this._entries = this._entries || new FeedMe.Collections.Entries();
    return this._entries;
  },

  parse: function (resp) {
    var entries;

    if (resp.entries) {
      this.entries().add(resp.entries, {merge: true });
      delete resp.entries;
    }

    if (resp.updating) {
      if (resp.updating === true && this.update_limit < 2) {
        window.setTimeout( this.fetch.bind(this), Constants.UPDATING_TIMEOUT);
        this.update_limit ++;
      } else if (resp.updating === false) {
        this.update_limit = 0;
      }
      delete resp.updating;
    }

    return resp;
  }
});

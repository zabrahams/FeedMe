FeedMe.Models.Feed = Backbone.Model.extend({
  urlRoot: "/api/feeds",

  entries: function () {
    this._entries = this._entries || new FeedMe.Collections.Entries();
    return this._entries;
  },

  parse: function (resp) {
    var entries;

    if (resp.entries) {
      this.entries().set(resp.entries);
      delete resp.entries;
    }

    if (resp.updating) {
      console.log(resp.updating);
      if (resp.updating === true) {
        window.setTimeout( this.fetch.bind(this), Constants.UPDATING_TIMEOUT);
      }
      delete resp.updating;
    }

    return resp;
  }
});

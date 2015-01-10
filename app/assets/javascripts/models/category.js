FeedMe.Models.Category = Backbone.Model.extend({

  urlRoot: "/api/categories",

  entries: function () {
    this._entries = this._entries || new FeedMe.Collections.Entries();
    return this._entries;
  },

  parse: function (resp) {
    var entries;

    if (resp.entries) {
      this.entries().set(resp.entries);
      delete resp.entries
    }

    return resp;
  }

});

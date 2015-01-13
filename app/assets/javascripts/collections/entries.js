FeedMe.Collections.Entries = Backbone.Collection.extend({

  model: FeedMe.Models.Entry,

  url: "/api/entries",

  parse: function (resp) {
    var updating = resp.updating;

    if (updating === true) {
      window.setTimeout(this.fetch.bind(this), Constants.UPDATING_TIMEOUT);
    }

    return resp.entries;
  }
});

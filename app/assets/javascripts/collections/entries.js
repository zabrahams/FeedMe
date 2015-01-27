FeedMe.Collections.Entries = Backbone.Collection.extend({

  initialize: function () {
    this.update_limit = 0;
  },


  model: FeedMe.Models.Entry,

  url: "/api/entries",

  parse: function (resp) {
    if (resp.updating) {

      console.log(resp.updating);
      console.log(resp.updated_at);
      console.log(resp.name);
      console.log(this.update_limit);
      if (resp.updating === true && this.update_limit < 2) {
        window.setTimeout( this.fetch.bind(this, { remove: false}), Constants.UPDATING_TIMEOUT);
        this.update_limit ++;
      } else if (resp.updating === false) {
        this.update_limit = 0;
      }

      delete resp.updating;
    }

    return resp.entries;
  }
});

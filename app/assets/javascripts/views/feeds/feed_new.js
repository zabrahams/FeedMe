FeedMe.Views.FeedNew = Backbone.View.extend({

  events: {
    "submit": "createFeed"
  },

  template: JST['feeds/new'],

  render: function () {
    this.$el.html(this.template());
    return this;
  },

  createFeed: function (event) {
    event.preventDefault();
    var feed, feeds, attr;

    feeds = this.collection
    feed = new FeedMe.Models.Feed();

    attrs = $(event.currentTarget).serializeJSON();
    feed.save(attrs, {
      success: function () {
        feeds.add(feed, { merge: true });
        Backbone.history.navigate("#/feeds/" + feed.id, { trigger: true });
      },

      error: function (model, resp) {
        console.log(resp.responseText);
      }
    });
  }

})

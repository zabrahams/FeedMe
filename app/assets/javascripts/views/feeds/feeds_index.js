FeedMe.Views.FeedsIndex = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.collection, "add remove reset change:name", this.render);
  },

  events: {
    "click button.remove-feed": "removeFeed"
  },

  template: JST['feeds/index'],

  render: function() {
    this.$el.html(this.template( { feeds: this.collection }));
    return this;
  },

  removeFeed: function (event) {
    var $button, feedId, feed;
    event.preventDefault();

    $button = $(event.currentTarget);
    feedId = $button.data("id");
    feed = this.collection.get(feedId);

    $.ajax("api/feeds/" + feedId + "/remove", {
      type: "POST",
      success: function () {
        this.collection.remove(feed);
      }.bind(this),

      error: function () {
        FeedMe.vent.trigger("errorFlash", "Error removing feed!");
      }
    })

  }

});

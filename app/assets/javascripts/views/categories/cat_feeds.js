FeedMe.Views.CatFeeds = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "click button.expand": "expandCategory",
    "click button.delete-category": "deleteCategory",
    "click button.remove-feed": "removeFeed"
  },

  template: JST['categories/cat_feeds'],

  render: function () {
    this.$el.html(this.template( { category: this.model } ));
    return this;
  },

  expandCategory: function (event) {
    event.preventDefault();

    this.$(".cat-feed-list").toggleClass("closed");
    this.$el.toggleClass("highlighted");
  },

  deleteCategory: function (event) {
    this.model.destroy({
      success: function () {
        this.render();
      }.bind(this),
      error: function () {
        console.log("Error deleting category.");
      }
    });
  },

  removeFeed: function (event) {
    var $button, feedId, feed, category;
    event.preventDefault();

    $button = $(event.currentTarget);
    feedId = $button.data("feed-id");
    feed = FeedMe.feeds.get(feedId);
    console.log(feedId);
    category = this.model;

    category.feeds().remove(feed);
    category.save({}, {

      success: function (model, resp) {
        this.$("li.feed-" + feedId).remove();
      }.bind(this),

      error: function () {
        console.log("Error updating the catgory.");
      }
    });
  },


});

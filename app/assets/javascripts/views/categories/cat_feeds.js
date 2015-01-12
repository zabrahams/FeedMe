FeedMe.Views.CatFeeds = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.model, "sync", this.render.bind(this, { open: true }));
  },

  events: {
    "click button.expand": "expandCategory",
    "click button.delete-category": "deleteCategory",
    "click button.remove-feed": "removeFeed"
  },

  template: JST['categories/cat_feeds'],

  render: function (options) {
    this.$el.html(this.template( { category: this.model } ));
    if (options && options.open === true ) {
      this.expandCategory();
    }

    this.$el.droppable({
      drop: this.addFeed.bind(this)
    });

    return this;
  },

  expandCategory: function () {
    this.$(".cat-feed-list").toggleClass("closed");
    this.$("li.category-list-item").toggleClass("highlighted");
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

  addFeed: function (event, ui) {
    var feedId, feed, category;

    feedId = ui.draggable.data("id");
    feed = FeedMe.feeds.get(feedId);
    category = this.model;

    category.feeds().add(feed, { merge: true });
    category.save( {}, {

      success: function (model, resp) {
        this.$("li.feed-" + feedId).remove();
      }.bind(this),

      error: function () {
        console.log("Error updating the catgory.");
      }
    });
  },

  removeFeed: function (event) {
    var $button, feedId, feed, category;
    event.preventDefault();

    $button = $(event.currentTarget);
    feedId = $button.data("feed-id");
    feed = FeedMe.feeds.get(feedId);
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

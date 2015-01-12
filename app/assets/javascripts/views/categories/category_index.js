FeedMe.Views.CategoryIndex = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.collection, "add remove reset change:name", this.render);
  },

  events: {
    "click button.delete-category": "deleteCategory",
    "click button.expand": "expandCategory",
    "click button.remove-feed": "removeFeed"

  },

  template: JST['categories/index'],

  render: function () {
    this.$el.html(this.template( {categories: this.collection} ));
    return this;
  },

  deleteCategory: function (event) {
    var $button, catId, category;
    event.preventDefault();

    $button = $(event.currentTarget);
    catId = $button.data("id");
    category = this.collection.get(catId);
    category.destroy({
      success: function () {
        this.render();
      }.bind(this),
      error: function () {
        console.log("Error deleting category.")
      }
    });
  },

  expandCategory: function (event) {
    var $button, catId, $feedList;
    event.preventDefault();

    $button = $(event.currentTarget);
    catId = $button.data("id");
    $feedList = this.$(".cat-" + catId);
    $feedList.toggleClass("closed");
  },

  removeFeed: function (event) {
    var $button, feedId, feed, catId, category;
    event.preventDefault();

    $button = $(event.currentTarget);
    feedId = $button.data("feed-id");
    feed = FeedMe.feeds.get(feedId);
    catId = $button.data("cat-id")
    category = this.collection.get(catId);

    category.feeds().remove(feed);
    category.save({}, {

      success: function (model, resp) {
        $("ul.cat-" + catId + " li.feed-" + feedId).remove();
      }.bind(this),

      error: function () {
        console.log("Error updating the catgory.");
      }
    });
  }

});

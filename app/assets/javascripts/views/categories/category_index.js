FeedMe.Views.CategoryIndex = Backbone.CompositeView.extend({

  initialize: function () {
    this.listenTo(this.collection, "add remove reset", this.render);
  },

  events: {
    "click button.delete-category": "deleteCategory",
    "click button.expand": "expandCategory",
    "click button.remove-feed": "removeFeed",
    "click section.new-category label": "newCategory"
  },

  template: JST['categories/index'],

  render: function () {
    this.$el.html(this.template( {categories: this.collection} ));
    this.attachFeedList();
    var $newEl = this.$("section.new-category");
    var categoryNewView = new FeedMe.Views.CategoryNew({});
    this.addSubView(categoryNewView, $newEl)

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

  newCategory: function (event) {
    event.preventDefault();

    $(".new-cat-form").toggleClass("closed");
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
  },

  attachFeedList: function () {
    FeedMe.feeds.fetch();
    var $feedUL = $("<ul>").addClass("feed-list");
    var $feedDiv = $("<div>").addClass("cat-feed-list-container");
    var feedList = new FeedMe.Views.FeedList({
      collection: FeedMe.feeds,
      el: $feedUL.get()
    });

    this.$el.append($feedDiv);
    this.addSubView(feedList, $feedDiv);
  }

});

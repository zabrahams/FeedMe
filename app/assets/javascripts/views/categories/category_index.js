FeedMe.Views.CategoryIndex = Backbone.CompositeView.extend({

  initialize: function () {
    this.listenTo(this.collection, "add remove reset", this.render);
  },

  events: {
    "click section.new-category label": "newCategory"
  },

  template: JST['categories/index'],

  render: function () {
    var view = this;

    this.$el.html(this.template( {categories: this.collection} ));
    this.attachFeedList();

    this.attachNewCatForm();

    var $catList = this.$(".category-list");
    this.collection.each(function (category) {
      view.attachCatEntry(category, $catList);
    });

    return this;
  },


  newCategory: function (event) {
    event.preventDefault();

    $(".new-cat-form").toggleClass("closed");
  },


  attachFeedList: function () {
    FeedMe.feeds.fetch();
    var $feedUL = $("<ul>").addClass("feed-list gen-list cat-feed-list");
    var $feedDiv = $("<div>").addClass("cat-feed-list-container group");
    var feedList = new FeedMe.Views.FeedList({
      collection: FeedMe.feeds,
      el: $feedUL.get()
    });

    this.$el.append($feedDiv);
    this.addSubView(feedList, $feedDiv);
  },

  attachNewCatForm: function () {
    var $newEl = this.$("section.new-category");
    var categoryNewView = new FeedMe.Views.CategoryNew({});
    this.addSubView(categoryNewView, $newEl);
  },

  attachCatEntry: function (category, $catList) {
    var categoryView = new FeedMe.Views.CatFeeds( { model: category });
    this.addSubView(categoryView, $catList);
  }

});

FeedMe.Routers.Router = Backbone.Router.extend({

  initialize: function (options) {
    this.$mainEl = options.$mainEl;
  },

  routes: {
    "":"feedsIndex",
    "feeds/new": "feedNew",
    "feeds/:id": "feedShow",
    "entries" : "entryIndex",
    "categories": "categoryIndex",
    "categories/:id": "categoryShow"
  },

  feedsIndex: function () {
    var feedsIndexView;

    FeedMe.feeds.fetch();
    feedsIndexView = new FeedMe.Views.FeedsIndex({ collection: FeedMe.feeds });
    this._swapView(feedsIndexView);
  },

  feedShow: function (id) {
    var feed, feedShowView;

    feed = FeedMe.feeds.getOrFetch(id);
    feedShowView = new FeedMe.Views.FeedShow({ model: feed });
    this._swapView(feedShowView);
  },

  feedNew: function () {
    var feedNewView = new FeedMe.Views.FeedNew({ collection: FeedMe.feeds });
    this._swapView(feedNewView);
  },

  entryIndex: function () {
    var entries, entryIndexView

    entries = new FeedMe.Collections.Entries();
    entries.fetch();
    entryIndexView = new FeedMe.Views.EntryIndex({ collection: entries });
    this._swapView(entryIndexView);
  },

  categoryIndex: function () {
    var categoryIndexView;

    FeedMe.categories.fetch();
    categoryIndexView = new FeedMe.Views.CategoryIndex({ collection: FeedMe.categories });
    this._swapView(categoryIndexView)
  },

  categoryShow: function (id) {
    var category, categoryShowView;

    category = FeedMe.categories.getOrFetch(id);
    categoryShowView = new FeedMe.Views.CategoryShow({ model: category });
    this._swapView(categoryShowView);
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$mainEl.html(view.render().$el);
  }
});

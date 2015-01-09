FeedMe.Routers.Router = Backbone.Router.extend({

  initialize: function (options) {
    this.$mainEl = options.$mainEl;
  },

  routes: {
    "":"feedsIndex",
    "feeds/new": "feedNew",
    "feeds/:id": "feedShow",
    "entries" : "entryIndex"
  },

  feedsIndex: function () {
    FeedMe.feeds.fetch();
    var feedsIndexView = new FeedMe.Views.FeedsIndex({ collection: FeedMe.feeds });
    this._swapView(feedsIndexView);
  },

  feedShow: function (id) {
    var feed = FeedMe.feeds.getOrFetch(id);
    var feedShowView = new FeedMe.Views.FeedShow({ model: feed });
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

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$mainEl.html(view.render().$el);
  }
});

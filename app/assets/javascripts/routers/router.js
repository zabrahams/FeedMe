FeedMe.Routers.Router = Backbone.Router.extend({

  initialize: function (options) {
    this.$mainEl = options.$mainEl;
  },

  routes: {
    "":"feedsIndex",
    "feeds/:id": "feedShow"
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

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$mainEl.html(view.render().$el);
  }
});

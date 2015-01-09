FeedMe.Routers.Router = Backbone.Router.extend({
  routes: {
    "":"feedsIndex"
  },

  feedIndex: function () {
    FeedMe.feeds.fetch();
    feedsIndexView = new FeedMe.Views.FeedsIndex( {collection: FeedMe.feeds });
    this._swapView(feedsIndexView);
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$mainEl.html(view.render().$el);
  }
});

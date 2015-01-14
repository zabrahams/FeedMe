FeedMe.Routers.Router = Backbone.Router.extend({

  initialize: function (options) {
    var sidebarView;

    this.$mainEl = options.$mainEl;
    this.$sidebarEl = options.$sidebarEl;

    sidebarView = new FeedMe.Views.Sidebar();
    this.$sidebarEl.html(sidebarView.render().$el);
  },

  routes: {
    "": "splash",
    "feeds":"feedsIndex",
    "feeds/new": "feedNew",
    "feeds/:id": "feedShow",
    "entries" : "entryIndex",
    "entries/recent": "recentlyRead",
    "categories": "categoryIndex",
    "categories/:id": "categoryShow",
    "users/new": "userNew",
    "users/edit": "userEdit",
    "users/:id": "userShow",
    "session/new": "sessionNew"
  },

  feedsIndex: function () {
    var feedsIndexView;

    if (!this._requireLogin()) {return false;}
    FeedMe.feeds.fetch();
    feedsIndexView = new FeedMe.Views.FeedsIndex({ collection: FeedMe.feeds });
    this._swapView(feedsIndexView);
  },

  splash: function () {
    var splashView;

    splashView = new FeedMe.Views.Splash();
    this._swapView(splashView);
  },

  feedShow: function (id) {
    var feed, feedShowView;

    if (!this._requireLogin()) {return false;}
    feed = FeedMe.feeds.getOrFetch(id);
    feedShowView = new FeedMe.Views.FeedShow({ model: feed });
    this._swapView(feedShowView);
  },

  feedNew: function () {
    var feedNewView;

    if (!this._requireLogin()) {return false;}
    feedNewView = new FeedMe.Views.FeedNew({ collection: FeedMe.feeds });
    this._swapView(feedNewView);
  },

  entryIndex: function () {
    var entries, entryIndexView;

    if (!this._requireLogin()) {return false;}
    entries = new FeedMe.Collections.Entries();
    entries.fetch();
    entryIndexView = new FeedMe.Views.EntryIndex({ collection: entries });
    this._swapView(entryIndexView);
  },

  recentlyRead: function () {
    var readEntries, recentlyReadView;

    if (!this._requireLogin()) {return false;}
    readEntries = new FeedMe.Collections.RecentlyRead();
    readEntries.fetch();
    recentlyReadView = new FeedMe.Views.RecentlyReadIndex({ collection: readEntries });
    this._swapView(recentlyReadView);
  },

  categoryIndex: function () {
    var categoryIndexView;

    if (!this._requireLogin()) {return false;}
    FeedMe.categories.fetch();
    categoryIndexView = new FeedMe.Views.CategoryIndex({ collection: FeedMe.categories });
    this._swapView(categoryIndexView);
  },

  categoryShow: function (id) {
    var category, categoryShowView;

    if (!this._requireLogin()) {return false;}
    category = FeedMe.categories.getOrFetch(id);
    categoryShowView = new FeedMe.Views.CategoryShow({ model: category });
    this._swapView(categoryShowView);
  },

  userNew: function () {
    var user, userNewView;

    if (!this._requireLogout()) {return false;}
    user = new FeedMe.Models.User();
    userNewView = new FeedMe.Views.UserNew({ model: user });
    this._swapView(userNewView);
  },

  userShow: function (id) {
    var user, userShowView;

    if (!this._requireLogin()) {return false;}
    user = FeedMe.users.getOrFetch(id);
    userShowView = new FeedMe.Views.UserShow({ model: user });
    this._swapView(userShowView);
  },

  userEdit: function (id) {
    var user, userEditView;

    FeedMe.currentUser.fetch();
    if (!this._requireLogin()) {return false;}
    user = FeedMe.users.getOrFetch(FeedMe.currentUser.id);
    userEditView = new FeedMe.Views.UserEdit({ model: user });
    this._swapView(userEditView);
  },

  sessionNew: function () {
    var sessionNewView;

    if (!this._requireLogout()) {return false;}
    sessionNewView = new FeedMe.Views.SessionNew();
    this._swapView(sessionNewView);
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$mainEl.html(view.render().$el);
  },

  _requireLogin: function () {
    var loggedIn = FeedMe.currentUser.loggedIn();
    if (!loggedIn) {
      Backbone.history.navigate("", { trigger: true });
    }
    return loggedIn;
  },

  _requireLogout: function () {
    var loggedOut = !FeedMe.currentUser.loggedIn();

    if (!loggedOut) {
      Backbone.history.navigate("", { trigger: true });
    }
    return loggedOut;
  },


});

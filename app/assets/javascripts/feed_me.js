window.FeedMe = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    this.feeds = new FeedMe.Collections.Feeds();
    this.feeds.fetch();
    this.categories = new FeedMe.Collections.Categories();
    this.categories.fetch();
    this.users = new FeedMe.Collections.Users();
    this.users.fetch();

    this.currentUser = new FeedMe.Models.CurrentUser();
    this.currentUser.fetch();

    new FeedMe.Routers.Router ({
      $mainEl:    $("main"),
      $sidebarEl: $("#sidebar-sec")
    });
    Backbone.history.start();
  }
};

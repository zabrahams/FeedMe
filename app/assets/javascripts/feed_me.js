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
    new FeedMe.Routers.Router ({
      $mainEl: $("main")
    });
    Backbone.history.start();
  }
};

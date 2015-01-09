window.FeedMe = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    this.feeds = new FeedMe.Collections.Feeds();
    this.feeds.fetch();
    new FeedMe.Routers.Router ({
      $mainEl: $("main")
    })
    Backbone.history.start();
  }
};

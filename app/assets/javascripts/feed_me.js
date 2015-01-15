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

    FeedMe.vent = _.extend({}, Backbone.Events);
    $(document).bind('keydown', function (event) {
      console.log("hello")
      var key = event.keyCode;
      FeedMe.vent.trigger("keyEvent", key);
    })


    this.currentUser = new FeedMe.Models.CurrentUser();
    this.currentUser.fetch({
      success: function () {
        new FeedMe.Routers.Router ({
          $mainEl:    $("main"),
          $sidebarEl: $("#sidebar-sec")
        });
        Backbone.history.start();
      },

        error: function () {
        new FeedMe.Routers.Router ({
          $mainEl:    $("main"),
          $sidebarEl: $("#sidebar-sec")
        });
        Backbone.history.start();

      }
    });


  }
};

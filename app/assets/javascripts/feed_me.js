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
      var key = event.keyCode;
      FeedMe.vent.trigger("keyEvent", key);
    })


    this.currentUser = new FeedMe.Models.CurrentUser();
    this.currentUser.fetch({
      complete: function () {
        new FeedMe.Routers.Router ({
          $mainEl:    $("main"),
          $sidebarEl: $("#sidebar-sec"),
          $modalEl:   $("#modal-sec"),
          $errorEl:   $("#error-sec"),
          $noticeEl:  $("#notice-sec")
        });
        Backbone.history.start();
      }
    });


  }
};

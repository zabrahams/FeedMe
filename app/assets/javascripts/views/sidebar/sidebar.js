FeedMe.Views.Sidebar = Backbone.View.extend({

  initialize: function () {
    this.listenTo(FeedMe.currentUser, "logIn logOut", this.render);
  },

  tagName: "nav",

  className: "sidebar group",

  events: {
    "click a.key-command-open": "openKeyCommand",
    "click button.logout": "logoutCurrentUser",
    "submit form.demo-user-form": "loginDemoUser",
    "transitionend": "showSidebar",
    "mouseleave": "hideSidebar"
  },

  template: function () {
      if (FeedMe.currentUser.loggedIn() === true) {
      return JST['sidebar/logged_in'];
    } else {
      return JST['sidebar/not_logged_in'];
    }
  },

  render: function () {
    this.$el.html(this.template()( { user: FeedMe.currentUser } ));
    if (this.$el[0].clientWidth > 100) {
      this.$('#sidebar-content').removeClass("closed");
    }
    return this;
  },

  openKeyCommand: function (event) {
    var keyMapView, $dialog;

    event.preventDefault();
    $(".modal-container").removeClass("closed");

  },

  logoutCurrentUser: function () {
    FeedMe.currentUser.logout();
  },

  loginDemoUser: function (event) {
    var attrs, session;

    event.preventDefault();
    attrs = this.$('form').serializeJSON();
    FeedMe.currentUser.save(attrs, {
      success: function () {
        Backbone.history.navigate("", { trigger: true });
      },

      error: function (model, resp) {
        var error = resp.responseJSON.errors;
        FeedMe.vent.trigger("errorFlash", error);
      }
    });
  },

  showSidebar: function (event) {
    console.log(this.$el[0].clientWidth)
    if (this.$el[0].clientWidth > 100) {
      this.$('#sidebar-content').removeClass("closed");
    }
  },

  hideSidebar: function (event) {
    this.$('#sidebar-content').addClass("closed");
  }

});

FeedMe.Views.Sidebar = Backbone.View.extend({

  initialize: function () {
    this.listenTo(FeedMe.currentUser, "logIn logOut", this.render);
  },

  tagName: "nav",

  className: "sidebar group",

  events: {
    "click a.key-command-open": "openKeyCommand",
    "click button.logout": "logoutCurrentUser"
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


});

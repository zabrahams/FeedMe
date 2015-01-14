FeedMe.Views.Sidebar = Backbone.View.extend({

  initialize: function () {
    this.listenTo(FeedMe.currentUser, "logIn logOut", this.render);
  },

  tagName: "nav",

  className: "sidebar group",

  events: {
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

  logoutCurrentUser: function () {
    FeedMe.currentUser.logout();
  }

});

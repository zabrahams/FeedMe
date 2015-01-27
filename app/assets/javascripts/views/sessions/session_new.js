FeedMe.Views.SessionNew = Backbone.View.extend({

  events: {
    "submit form": "login"
  },

  template: JST['sessions/new'],

  render: function () {
    this.$el.html(this.template());
    return this;
  },

  login: function (event) {
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
  }
  
});

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
    session = new FeedMe.Models.Session();
    session.save(attrs, {
      success: function () {
        Backbone.history.navigate("", { trigger: true });
      }
    });
  }

});

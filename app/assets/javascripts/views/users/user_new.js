FeedMe.Views.UserNew = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.collection, "add remove reset", this.render)
  },

  events: {
    "submit form": "createUser"
  },

  template: JST['users/new'],

  render: function () {
    this.$el.html(this.template({
      user: this.model,
      questions: this.collection
    }));
    return this;
  },

  createUser: function (event) {
    var user, attrs;
    event.preventDefault();

    attrs = this.$("form").serializeJSON();

    if (attrs.user.password !== attrs.user.password_confirmation) {
      FeedMe.vent.trigger("errorFlash", "Password and Confirmation do not match.")
      return;
    } else {
      user = new FeedMe.Models.User();

      user.set(attrs);

      user.save({}, {
        success: function (model, resp) {
          FeedMe.users.add(user);
          Backbone.history.navigate("", { trigger: true });
          console.log(resp.notice)
          FeedMe.vent.trigger("noticeFlash", resp.notice)
        },
        error: function (model, resp) {
          FeedMe.vent.trigger("errorFlash", resp.responseJSON.errors);
        }
      });
    }
  }

})

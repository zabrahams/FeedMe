FeedMe.Views.UserNew = Backbone.View.extend({

  events: {
    "submit form": "createUser"
  },

  template: JST['users/new'],

  render: function () {
    this.$el.html(this.template({ user: this.model}));
    return this;
  },

  createUser: function (event) {
    var user, attrs;
    event.preventDefault();

    attrs = this.$("form").serializeJSON();

    if (attrs.user.password !== attrs.user.password_confirmation) {
      console.log("Password and Confirmation do not match.")
      return;
    } else {
      user = new FeedMe.Models.User();
      console.log(attrs); 
      user.set(attrs);

      user.save({}, {
        success: function () {
          FeedMe.users.add(user);
          Backbone.history.navigate("", { trigger: true });
        },
        error: function () {
          console.log("Error saving new user.");
        }
      });
    }
  }

})

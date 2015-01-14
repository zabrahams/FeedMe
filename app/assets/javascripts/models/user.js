FeedMe.Models.User = Backbone.Model.extend({

  urlRoot: "/api/users",

  toJSON: function () {
    var json = { user: _.clone(this.attributes.user) };

    console.log(json);

    if (this._image) {
      json.user.image = this._image;
    }

    return json;
  }

});

FeedMe.Models.CurrentUser = FeedMe.Models.User.extend({

  initialize: function () {
    this.listenTo(this, "change", this.loginStatusChange);
  },

  url: "api/session",

  loggedIn: function () {
    return !this.isNew();
  },

  logout: function () {
    var model = this;

    $.ajax({
      type: "DELETE",
      url: this.url,
      dataType: "json",
      success: function () {
        model.clear();
      }
    });

  },

  loginStatusChange: function () {
    if (this.loggedIn()) {
      this.trigger("logIn");
    } else {
      this.trigger("logOut");
    }
  }


});

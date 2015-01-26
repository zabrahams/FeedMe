FeedMe.Models.User = Backbone.Model.extend({

  urlRoot: "/api/users",

  toJSON: function () {
    var json = { user: _.clone(this.attributes.user) };

    if (this._image) {
      json.user.image = this._image;
    }

    return json;
  },

  curators: function () {
    this._curators = this._curators || new FeedMe.Collections.Users();
    return this._curators;
  },

  watchers: function () {
    this._watchers = this._watchers || new FeedMe.Collections.Users();
    return this._watchers;
  },

  parse: function(resp) {

    if (resp.curators) {
      this.curators().set(resp.curators);
      delete resp.curators;
    }

    if (resp.watchers) {
      this.watchers().set(resp.watchers);
      delete resp.watchers;
    }


    return resp;
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
      success: function (resp) {
        FeedMe.vent.trigger("noticeFlash", resp.notice);
        model.clear();
        Backbone.history.navigate("", { trigger: true });
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

FeedMe.Models.User = Backbone.Model.extend({

  urlRoot: "/api/users",

  toJSON: function () {
    var json = { user: _.clone(this.attributes.user) };

    if (this._image) {
      json.user.image = this._image;
    }

    return json;
  }

});

FeedMe.Collections.Users = Backbone.Collection.extend({

  model: FeedMe.Models.User,

  url: "/api/users",

  getOrFetch: function (id) {
    var user = this.find(id);

    if (user) {
      user.fetch();
    } else {
      user = new FeedMe.Models.User( {id: id} );
      user.fetch({
        success: function () {
          this.add(user, { merge: true });
        }.bind(this)
      });
    }
    return user;
  }

});

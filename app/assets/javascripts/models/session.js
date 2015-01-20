FeedMe.Models.Session = Backbone.Model.extend({

  urlRoot: "/api/session",

  toJSON: function () {
    return _.clone(this.attributes)

  }

});

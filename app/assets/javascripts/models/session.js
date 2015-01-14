FeedMe.Models.Session = Backbone.Model.extend({

  urlRoot: "/api/session",

  toJSON: function () {
    console.log(this.attributes)
    return _.clone(this.attributes)

  }

});

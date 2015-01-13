FeedMe.Views.UserEdit = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "submit form": "updateUser"
  },

  template: JST['users/edit'],

  render: function () {
    this.$el.html(this.template( { user: this.model } ));
    return this;
  },

  updateUser: function (event) {
    var attrs;
    event.preventDefault();

    attrs = this.$("form").serializeJSON();
    this.model.set(attrs);
    this.model.save({}, {
       error: function(model, response) {
         console.log(response);
       }
    });

  }

});

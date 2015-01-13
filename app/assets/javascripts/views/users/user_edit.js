FeedMe.Views.UserEdit = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "submit form": "updateUser",
    "change #user_image": "fileInputChange"
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

  },

  fileInputChange: function (event) {

    var that = this;
    var file = event.currentTarget.files[0];
    var reader = new FileReader();

    reader.onloadend = function() {
      that.model._image = reader.result;
    };

    if (file) {
      reader.readAsDataURL(file);
    } else {
      delete this.model._image;
    }
  }

});

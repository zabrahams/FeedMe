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
    this.$el.html(this.template( {user: this.model} ));
    return this;
  },

  updateUser: function (event) {
    var attrs;
    event.preventDefault();

    attrs = this.$("form").serializeJSON();

    if (attrs.user.password !== attrs.user.password_confirmation) {
      FeedMe.vent.trigger("errorFlash", "Password and Confirmation do not match.")
      return;
    } else {

      // Since a blank password is "" and not nil, it causes problems if
      // uploaded to the server. So I delete it from params client-side.
      if (attrs.user.password.length === 0) {
        console.log("in password deletion")
        delete attrs.user.password
        delete attrs.user.password_confirmation
      }

      this.model.set(attrs);
      this.model.save({}, {
         error: function(model, resp) {
           FeedMe.vent.trigger("errorFlash", resp.responseJSON);
         },

         success: function() {
           FeedMe.vent.trigger("noticeFlash", "Profile Updated");
         }
      });
    }
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

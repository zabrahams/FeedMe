FeedMe.Views.SessionUsername = Backbone.View.extend({

  events: {
    "submit form": "sendUsernameEmail"
  },

  template: JST['sessions/username'],

  render: function () {
    this.$el.html(this.template());
    return this;
  },

  sendUsernameEmail: function(event) {
    var email;

    event.preventDefault();

    email = this.$('form').serializeJSON();

    $.ajax({
      type: "POST",
      url: "api/session/username",
      dataType: "json",
      data: email,
      success: function (resp) {
        console.log(resp.responseJSON.notice);
      },

      error: function (resp) {
        console.log(resp.responseJSON.errors);
      }
    })


  }

});

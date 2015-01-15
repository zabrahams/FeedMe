FeedMe.Views.UserShow = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  events: {
    "click button.follow-btn": "toggleFollow"
  },

  template: JST['users/show'],

  render: function () {
    var buttonText, curators;

    curators = FeedMe.currentUser.curators();
    console.log(curators);

    console.log(this.weakContains(curators, this.model));
    if (this.weakContains(curators, this.model)) {
      buttonText = "DeWatch!";
    } else {
      buttonText = "Watch!";
    }

    this.$el.html(this.template ( {
      user: this.model,
      buttonText: buttonText
      }));
    return this;
  },

  toggleFollow: function (event) {
    var $button, ajaxUrl, curators;

    event.preventDefault();
    curators = FeedMe.currentUser.curators();
    $button = $(event.currentTarget);
    ajaxUrl = "api/users/" + this.model.id + "/followings";

    if (this.weakContains(curators, this.model)) {
      console.log("hi");
      $.ajax({
        type: "DELETE",
        dataType: "json",
        url: ajaxUrl,
        success: function () {
          FeedMe.currentUser.fetch({
            success: function () {
              $button.html("Watch!");
            }
          });
        }
      });
    } else {
      console.log("bye");
      $.ajax({
        type: "POST",
        dataType: "json",
        url: ajaxUrl,
        success: function () {
          FeedMe.currentUser.fetch({
            success: function () {
              $button.html("DeWatch!");
            }
          });
        }
      });
    }
  },

  weakContains: function(collection, model) {
    return collection.any(function (el) {
      if (el.id === model.id && el.escape('username') === model.escape('username')) {
        return true;
      }
      return false;
    });
  }

});

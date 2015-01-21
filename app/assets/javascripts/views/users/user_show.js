FeedMe.Views.UserShow = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
    this.comments = new FeedMe.Collections.Comments({ commentable: this.model });
    this.comments.fetch({
      success: function () {
        console.log("Comments fetched")
        this._commentIndexView = new FeedMe.Views.CommentList({
          collection: this.comments,
          commentableType: "User",
          commentableId: this.model.id.toString()
        });

        this.render();
      }.bind(this)
    });
  },

  events: {
    "click button.follow-btn": "toggleFollow"
  },

  template: JST['users/show'],

  render: function () {
    var buttonText, curators, commentIndexView;

    curators = FeedMe.currentUser.curators();

    if (this.weakContains(curators, this.model)) {
      buttonText = "DeWatch!";
    } else {
      buttonText = "Watch!";
    }

    this.$el.html(this.template ( {
      user: this.model,
      buttonText: buttonText
      }));

    this._commentIndexView && this.$el.append(this._commentIndexView.render().$el)

    return this;
  },

  toggleFollow: function (event) {
    var $button, ajaxUrl, curators;

    event.preventDefault();
    curators = FeedMe.currentUser.curators();
    $button = $(event.currentTarget);
    ajaxUrl = "api/users/" + this.model.id + "/followings";

    if (this.weakContains(curators, this.model)) {
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
  },

  remove: function () {
    this._commentIndexView.remove();
    Backbone.View.prototype.remove.call(this);
  }

});

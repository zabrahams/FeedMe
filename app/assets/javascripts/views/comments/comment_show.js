FeedMe.Views.CommentShow = Backbone.View.extend({

  tagName: "article",

  className: "comment",

  events: {
    "click button.delete": "deleteComment"
  },

  template: JST["comments/show"],

  render: function () {
    this.$el.html(this.template({comment: this.model}));
    return this;
  },

  deleteComment: function (event) {
    event.preventDefault();
    this.model.destroy({
      wait: true,
      success: this.remove,
      error: function (model, resp) {
        FeedMe.vent.trigger("errorFlash", resp.responseJSON.errors);
      }
    });
  }

});

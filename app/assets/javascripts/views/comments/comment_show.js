FeedMe.Views.CommentShow = Backbone.View.extend({

  initialize: function (options) {
    this.parent = options.parent
  },

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
      success: this.remove.bind(this),
      error: function (model, resp) {
        FeedMe.vent.trigger("errorFlash", resp.responseJSON.errors);
      }
    });
  },

  remove: function () {
    var viewIdx;

    console.log(this.parent);
    viewIdx = this.parent._elemViews.indexOf(this);
    this.parent._elemViews.splice(viewIdx, 1);
    Backbone.View.prototype.remove.call(this);
  }

});

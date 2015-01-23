FeedMe.Views.CommentShow = Backbone.View.extend({

  initialize: function (options) {
    this.parent = options.parent
  },

  tagName: "li",

  className: "comment-list-item gen-list-item group",

  events: {
    "click button.delete": "deleteComment",
    "click button.edit":   "editComment"
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

  editComment: function (event) {
    var commentForm;

    event.preventDefault();
    var commentForm = new FeedMe.Views.CommentForm( {
      collection: this.parent.collection,
      commentableType: this.parent.commentableType,
      commentableId: this.parent.commentableId,
      parent: this,
      model: this.model
    });

    this.$el.html(commentForm.render().$el);
  },

  remove: function () {
    var viewIdx;

    console.log(this.parent);
    viewIdx = this.parent._elemViews.indexOf(this);
    this.parent._elemViews.splice(viewIdx, 1);
    Backbone.View.prototype.remove.call(this);
  }

});

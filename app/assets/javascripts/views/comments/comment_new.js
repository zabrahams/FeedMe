FeedMe.Views.CommentNew = Backbone.View.extend({

  initialize: function (options) {
    this.commentableType = options.commentableType;
    this.commentableId   = options.commentableId;
    console.log(options.commentableType)
  },

  events: {
    "submit": "createComment"
  },

  tagName: "form",

  template: JST["comments/new"],

  render: function () {
    this.$el.html(this.template());
    return this;
  },

  createComment: function (event) {
    var attrs, comment;
    event.preventDefault();

    attrs = this.$el.serializeJSON();
    attrs.comment.commentable_type = this.commentableType;
    attrs.comment.commentable_id = this.commentableId;
    console.log(attrs);

    comment = new FeedMe.Models.Comment();
    comment.save(attrs, {
      success: function (model) {
        this.collection.add(model);
      }.bind(this),
      error: function (model, resp) {
        FeedMe.vent.trigger("errorFlash", resp.responseJSON);
      }
    });
  }



});

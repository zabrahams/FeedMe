FeedMe.Views.CommentForm = Backbone.View.extend({

  initialize: function (options) {
    this.commentableType = options.commentableType;
    this.commentableId   = options.commentableId;
    console.log(options.commentableType)
  },

  events: {
    "submit": "createComment"
  },

  tagName: "form",

  template: JST["comments/form"],

  render: function () {
    this.$el.html(this.template( {comment: this.model} ));
    return this;
  },

  createComment: function (event) {
    var attrs, comment;
    event.preventDefault();

    attrs = this.$el.serializeJSON();

    attrs.comment.commentable_type = this.commentableType;
    attrs.comment.commentable_id = this.commentableId;

    comment = this.model;

    attrs = attrs.comment
    console.log(attrs);
    comment.set(attrs);
    console.log(comment);
    comment.save({}, {
      success: function (model) {
        this.collection.add(model);
      }.bind(this),
      error: function (model, resp) {
        FeedMe.vent.trigger("errorFlash", resp.responseJSON);
      }
    });
  }



});

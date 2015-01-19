FeedMe.Views.CommentShow = Backbone.View.extend({

  tagName: "article",

  className: "comment",

  template: JST["comments/show"],

  render: function () {
    this.$el.html(this.template({comment: this.model}));
    return this;
  }

});

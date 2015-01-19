FeedMe.Collections.Comments = Backbone.Collection.extend({

  initialize: function (options) {
    this.commentable = options.commentable;
  },

  comparator: "created_at",

  model: FeedMe.Models.Comment,

  url: function () {
    var type, id;

    if (this.commentable instanceof FeedMe.Models.User) {
      type = "User";
    } else {
      type = "Entry";
    }
    id = this.commentable.id;

    return "api/comments?commentable[type]=" +
       type +
       "&commentable[id]=" +
       id;
  }

});

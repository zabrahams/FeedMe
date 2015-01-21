FeedMe.Models.Comment = Backbone.Model.extend({
  urlRoot: "api/comments",

  isAboutCurrUser: function () {
    var a = (this.escape('commentable_type') === "User" &&
      this.escape('commentable_id') === FeedMe.currentUser.id.toString());
      return a;
  },

  isByCurrUser: function () {
    return (this.author === FeedMe.currentUser.escape("username"));
  }
});

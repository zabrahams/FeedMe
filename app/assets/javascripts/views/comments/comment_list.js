FeedMe.Views.CommentList = Backbone.ListView.extend({

  initialize: function () {
    Backbone.ListView.prototype.intialize.call(this);
    this.listenTo(this.collection, "add remove reset sync", this.clearElemViews);
    this.listenTo(this.collection, "add remove reset sync", this.render);
  },

  tagName: "ul",

  className: "comment-list",

  template: JST['comments/list'],

  render: function () {
    this.$el.html(this.template());
    if (this._elemViews.length === 0) {
      this.updateViews()
    }
    this.renderElems();
    return this;
  },

  updateViews: function () {
    this.collection.each(function (comment) {
      var commentView = new FeedMe.Views.CommentShow( {model: comment });
      this._elemViews.push(commentView);
      this.$el.append(commentView.render().$el)
    }.bind(this));
  }

});
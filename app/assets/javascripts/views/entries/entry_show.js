FeedMe.Views.EntryShow = Backbone.View.extend({

  initialize: function () {
    this.comments = new FeedMe.Collections.Comments({ commentable: this.model });
    this.comments.fetch({
      success: function () {
        console.log("Comments fetched")
        this._commentIndexView = new FeedMe.Views.CommentList({
          collection: this.comments,
          commentableType: "Entry",
          commentableId: this.model.id.toString()
        });

        this.render();
      }.bind(this)
    });
  },

  events: {
    "click a.toggle-comments": "toggleComments"
  },

  template: JST['entries/show'],

  render: function () {
    this.$el.html(this.template({ entry: this.model }));

    this._commentIndexView && this.$el.append(this._commentIndexView.render().$el)

    return this;
  },

  toggleComments: function (event) {
    event.preventDefault();
    this._commentIndexView.$el.toggleClass("closed");
  }
})

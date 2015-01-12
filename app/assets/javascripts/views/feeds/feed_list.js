FeedMe.Views.FeedList = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.collection, "add remove reset", this.render);
  },

  template: JST["feeds/list"],

  render: function () {
    this.$el.html(this.template({ feeds: this.collection }));
    this.$('li.feed-list-item').draggable({
      revert: "invalid",
      helper: "clone"
    });
    return this;
  }

});

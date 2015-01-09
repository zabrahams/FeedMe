FeedMe.Views.FeedShow = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  template: JST['feeds/show'],

  render: function () {
    this.$el.html(this.template({ feed: this.model }));
    return this;
  }
})

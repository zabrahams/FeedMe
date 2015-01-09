FeedMe.Views.FeedsIndex = Backbone.View.extend({

  template: JST['feeds/index'],

  render: function() {
    this.$el.html(this.template( { feeds: this.collection }));
    return this;
  }

});

FeedMe.Views.Splash = Backbone.View.extend({

  template: JST['shared/splash'],

  render: function () {
    this.$el.html(this.template());
    return this;
  }

});

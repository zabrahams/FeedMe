FeedMe.Views.Splash = Backbone.View.extend({

  className: "splash",

  template: JST['shared/splash'],

  render: function () {
    this.$el.html(this.template());
    return this;
  }

});

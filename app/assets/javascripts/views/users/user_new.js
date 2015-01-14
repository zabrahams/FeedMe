FeedMe.Views.UserNew = Backbone.View.extend({

  template: JST['users/new'],

  render: function () {
    this.$el.html(this.template({ user: this.model}));
    return this;
  }

})

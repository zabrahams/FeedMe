FeedMe.Views.CategoryIndex = Backbone.View.extend({

  template: JST['categories/index'],

  render: function () {
    this.$el.html(this.template( {categories: this.collection} ));
    return this;
  }

});

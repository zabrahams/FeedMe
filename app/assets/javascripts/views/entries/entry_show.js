FeedMe.Views.EntryShow = Backbone.View.extend({

  template: JST['entries/show'],

  render: function () {
    console.log("hi")
    this.$el.html(this.template({ entry: this.model }));
    return this;
  }
})

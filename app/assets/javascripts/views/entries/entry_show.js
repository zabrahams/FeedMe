FeedMe.Views.EntryShow = Backbone.View.extend({

  tagName: "article",

  template: JST['entries/show'],

  render: function () {
    console.log(this.$el)
    this.$el.html(this.template({ entry: this.model }));
    return this;
  }
})

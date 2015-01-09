FeedMe.Views.EntryList = Backbone.View.extend({

  tagName: "ul",

  template: JST['entries/list'],

  render: function () {
    console.log(this.collection);
    this.$el.html(this.template({ entries: this.collection }));
    return this;
  }

});

FeedMe.Views.UserIndex = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.collection, "add remove reset", this.render);
  },

  tagName: "section",

  className: "user-page group",

  template: JST['users/index'],

  render: function () {
    this.$el.html(this.template({
      users:           this.collection,
      curators:  this.model.curators(),
      watchers: this.model.watchers()
    }));
    return this;
  }

});

FeedMe.Views.CategoryNew = Backbone.View.extend({

  initialize: function () {
    this.listenTo( this.collection, "add reset remove", this.render)
  },

  events: {
    "submit": "createCategory"
  },

  tagName: "form",

  template: JST['categories/form'],

  render: function () {
    this.$el.html(this.template( { feeds: this.collection }));
    return this;
  },

  createCategory: function (event) {
    event.preventDefault();
    var attrs, category;

    attrs = this.$el.serializeJSON();
    category = new FeedMe.Models.Category();
    category.set(attrs);
    category.save({}, {
      success: function () {
        FeedME.categories.add(category);
        Backbone.history.navigate("#/categories", { trigger: true })
      }.bind(this),

      error: function (model, resp) {
        console.log(resp.responseText)
      }
    })

  }

});

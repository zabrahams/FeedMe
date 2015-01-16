FeedMe.Views.CategoryNew = Backbone.View.extend({

  events: {
    "submit": "createCategory"
  },

  template: JST['categories/form'],

  render: function () {
    this.$el.html(this.template());
    return this;
  },

  createCategory: function (event) {
    event.preventDefault();
    var attrs, category;

    attrs = this.$el.find('form').serializeJSON();
    category = new FeedMe.Models.Category();
    category.set(attrs.category);
    category.save({}, {
      success: function () {
        FeedMe.categories.add(category);
        Backbone.history.navigate("#/categories", { trigger: true });
      }.bind(this),

      error: function (model, resp) {
        FeedMe.vent.trigger("errorFlash", resp.responseText);
      }
    });

  }

});

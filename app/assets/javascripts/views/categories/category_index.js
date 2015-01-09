FeedMe.Views.CategoryIndex = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.collection, "add remove reset change:name", this.render);
  },

  events: {
    "click button.delete": "deleteCategory"
  },

  template: JST['categories/index'],

  render: function () {
    this.$el.html(this.template( {categories: this.collection} ));
    return this;
  },

  deleteCategory: function (event) {
    var $button, catId, category;
    event.preventDefault();

    $button = $(event.currentTarget);
    catId = $button.data("id");
    category = this.collection.get(catId);
    category.destroy({
      success: function () {
        this.render();
      }.bind(this),
      error: function () {
        console.log("Error deleting category.")
      }
    });
  }

});

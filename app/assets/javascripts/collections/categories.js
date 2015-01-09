FeedMe.Collections.Categories = Backbone.Collection.extend({

  model: FeedMe.Models.Category,

  url: "/api/categories",

  getOrFetch: function (id) {
    var category = this.find(id);

    if (category) {
      category.fetch();
    } else {
      category = new FeedMe.Models.Category( {id: id} );
      category.fetch({
        success: function () {
          this.add(category, { merge: true });
        }.bind(this)
      });
    }
    return category
  }

});

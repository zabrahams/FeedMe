FeedMe.Collections.Categories = Backbone.Collection.extend({

  model: FeedMe.Models.Category,

  url: "/api/categories",

  comparator: "name",

  getOrFetch: function (id) {
    var category = this.find(id);

    if (category) {
      category.fetch({
        success: function () {
          if (category.get("updating") === true) {
            window.setTimeout( category.fetch.bind(category), 4000);
          }
        }
      });
    } else {
      category = new FeedMe.Models.Category( {id: id} );
      category.fetch({
        success: function () {
          this.add(category, { merge: true });
          if (category.get("updating") === true) {
            window.setTimeout( category.fetch.bind(category), 4000);
          }
        }.bind(this)
      });
    }
    return category
  }

});

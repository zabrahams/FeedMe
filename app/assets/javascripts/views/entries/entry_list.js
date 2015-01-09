FeedMe.Views.EntryList = Backbone.View.extend({

  tagName: "ul",

  events: {
    "click a.entry-title": "toggleEntry"
  },

  template: JST['entries/list'],

  render: function () {
    this.$el.html(this.template({ entries: this.collection }));
    return this;
  },

  toggleEntry: function (event) {
    event.preventDefault()

    var $title = $(event.currentTarget);
    if ($title.hasClass("been-opened")) {
      var $article = $title.siblings("article.entry");
      $article.toggleClass("open closed")
    } else {
      $title.addClass("been-opened");
      $article = $("<article>")
        .addClass("entry open")
        .html("I am an article!")
      $title.parent().append($article);
    }
  }

});

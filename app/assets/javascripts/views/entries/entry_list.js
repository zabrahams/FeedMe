FeedMe.Views.EntryList = Backbone.ListView.extend({

  initialize: function () {
    Backbone.ListView.prototype.intialize.call(this);
    this.listenTo(this.collection, "add remove reset sync", this.render)
  },

  tagName: "ul",

  events: {
    "click a.entry-title": "toggleEntry"
  },

  template: JST['entries/list'],

  render: function () {
    this.$el.html(this.template({ entries: this.collection }));
    this.renderElems();
    return this;
  },

  toggleEntry: function (event) {
    var $title, $article, entry;
    event.preventDefault()

    $title = $(event.currentTarget);
    $article = $title.siblings("article.entry");

    $article.toggleClass("open closed")

    if (!$title.hasClass("been-opened")) {
      $title.addClass("been-opened");
      entry = this.collection.get($article.data('id'));
      this.addElemView($article, entry)
    }
  }

});

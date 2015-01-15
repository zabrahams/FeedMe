FeedMe.Views.EntryList = Backbone.ListView.extend({

  initialize: function () {
    Backbone.ListView.prototype.intialize.call(this);
    this.listenTo(this.collection, "add remove reset sync", this.render);
    this._openEntries = [];
  },

  tagName: "ul",

  className: "entry-list",

  events: {
    "click a.entry-title": "toggleEntry"
  },

  template: JST['entries/list'],

  render: function () {
    this.$el.html(this.template({ entries: this.collection }));
    this._openEntries.forEach(this._keepEntryOpen.bind(this));
    this.renderElems();
    return this;
  },

  toggleEntry: function (event) {
    var $title, $article, entryId, entry;
    event.preventDefault();

    $title = $(event.currentTarget);
    $article = $title.siblings("article.entry");
    entryId = $article.data("id");

    $article.toggleClass("open closed");
    this._toggleOpenEntry(entryId);


    if (!$title.hasClass("been-opened")) {
      $title.addClass("been-opened");
      entry = this.collection.get(entryId);
      this.addElemView($article, entry);
      $.ajax("/api/entries/" + entryId + "/read", {
        type: "POST"
      });
    }
  },

  _toggleOpenEntry: function (entryId) {
    var entryIndex;

    entryIndex = this._openEntries.indexOf(entryId);
    if (entryIndex >= 0) {
      this._openEntries.splice(entryIndex, 1);
    } else {
      this._openEntries.push(entryId);
    }
  },

  _keepEntryOpen: function (entryId) {
    console.log("trying to keep it open");
    console.log(this._openEntries);
    var entry, $article, $title;

    $article = $("#article-entry-" + entryId);
    $article.removeClass("closed");
    $title = $("#entry-title-" + entryId);
    entry = this.collection.get(entryId);
    console.log(this.collection);
    console.log(entry);
    this.addElemView($article, entry);
    $title.addClass("been-opened");
  }

});

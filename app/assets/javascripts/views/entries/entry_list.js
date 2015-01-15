FeedMe.Views.EntryList = Backbone.ListView.extend({

  initialize: function() {
    Backbone.ListView.prototype.intialize.call(this);
    this.listenTo(this.collection, "add remove reset sync", this.render);
    this.listenTo(FeedMe.vent, "keyEvent", this.keyAction.bind(this));
    this._openEntries = [];
  },

  tagName: "ul",

  className: "entry-list",

  events: {
    "click a.entry-title": "toggleEntry",
  },

  template: JST['entries/list'],

  render: function () {
    this.$el.html(this.template({ entries: this.collection }));
    this._openEntries.forEach(this._keepEntryOpen.bind(this));
    this.renderElems();
    return this;
  },

  selectNext: function () {
    var $selected, $next;

    $selected = this.$(".selected");
    if ($selected.length === 0) {
      $next = $(".entry-list").children().first()
    } else {
      $next = $selected.next();
      $selected.toggleClass('selected');
    }

    $next.toggleClass('selected');
  },

  selectPrevious: function () {
    var $selected, $previous;

    $selected = this.$(".selected");
    if ($selected.length === 0) {
      $prev = $(".entry-list").children().last()
    } else {
      $prev = $selected.prev();
      $selected.toggleClass('selected');
    }

    $prev.toggleClass('selected');
  },



  toggleEntry: function (event) {
    var $title, $selected, $article, entryId, entry;

    if (typeof event === "undefined") {
      $selected = $(".selected");
      if ($selected.length === 0)
        return;
        else{
          $title = $selected.find('.entry-title');
        }
    }  else {
      event.preventDefault();
      $title = $(event.currentTarget);
    }

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

  openEntry: function () {
    var $selected, urlToOpen;

    $selected = $('.selected');
    if ($selected.length !== 0) {
      urlToOpen = $selected.find(".hidden-link").attr('value');
      window.open(urlToOpen);
    }
  },

  keyAction: function (key) {
    console.log(key);
    if (key === Constants.KEYS.n) {
      this.selectNext();
    } else if (key === Constants.KEYS.o) {
      this.openEntry();
    } else if (key === Constants.KEYS.p) {
      this.selectPrevious();
    } else if (key === Constants.KEYS.v) {
      this.toggleEntry();
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

FeedMe.Views.FeedShow = Backbone.View.extend({

  initialize: function () {
    this.listenTo(this.model, "sync", this.renderHeader);
  },

  template: JST['feeds/show'],

  render: function () {
    console.log("rendering from Feed");
    this.$el.html(this.template({ feed: this.model }));
    var entryList = new FeedMe.Views.EntryList({ collection: this.model.entries() });
    this._swapEntryList(entryList);
    return this;
  },

  // Super hacky, unless I move the headers out to subviews!

  renderHeader: function () {
    $(".page-title").html(this.model.get('name'));
  },

  remove: function () {
    Backbone.View.prototype.remove.call(this);
    this._entryList.remove();
  },

  _swapEntryList: function (newList) {
    this._entryList && this._entryList.remove();
    this._entryList = newList;
    this.$el.append(newList.render().$el);
  }
})

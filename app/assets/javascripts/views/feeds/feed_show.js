FeedMe.Views.FeedShow = Backbone.View.extend({

  template: JST['feeds/show'],

  render: function () {
    console.log("rendering from Feed");
    this.$el.html(this.template({ feed: this.model }));
    var entryList = new FeedMe.Views.EntryList({ collection: this.model.entries() });
    this._swapEntryList(entryList);
    return this;
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

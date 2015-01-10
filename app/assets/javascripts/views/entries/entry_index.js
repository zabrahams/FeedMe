FeedMe.Views.EntryIndex = Backbone.View.extend({

  template: JST['entries/index'],

  render: function () {
    this.$el.html(this.template());
    var entryList = new FeedMe.Views.EntryList({ collection: this.collection });
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

FeedMe.Views.CategoryShow = Backbone.View.extend({
  initialize: function () {
    this.listenTo( this.model, "sync", this.render );
  },

  template: JST['categories/show'],

  render: function () {
    this.$el.html(this.template({ category: this.model }));
    var entryList = new FeedMe.Views.EntryList({
      collection: this.model.entries(),
      model:      this.model
    });
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
});

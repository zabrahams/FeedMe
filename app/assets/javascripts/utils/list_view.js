Backbone.ListView = Backbone.View.extend({

  intialize: function () {
    this._elemViews = [];
  },

  addElemView: function ($article, entry) {
    var elemView = new FeedMe.Views.EntryShow({
      el: $article.get(),
      model: entry });
    this._elemViews.push(elemView);
    elemView.render();
  },

  renderElems: function () {
    this._elemViews.forEach( function (elemView) {
      elemView.render();
    });
  },

  remove: function () {
    Backbone.View.prototype.remove.call(this);
    this._elemViews.forEach( function (elemView) {
      elemView.remove();
    });
  },

  clearElemViews: function () {
    this._elemViews = []
  }

})

Backbone.CompositeView = Backbone.View.extend({

  addSubView: function (subview, $el) {
    this._subViews = this._subViews ? this._subViews : {}

  if (this._subViews.$el) {
    this._subViews.$el << subview;
  } else {
    this._subViews.$el = [subview];
  }
  $el.append(subview.render().$el);

  subview.delegateEvents();
  },


  remove: function () {
    var subKeys;
    var that = this;
    Backbone.View.prototype.remove.call(this);

    if (this._subViews) {
    subKeys = Object.keys(this._subViews);
      subKeys.forEach( function (subKey) {
        that._subViews[subKey].forEach( function (subView) {
          subView.remove();
        });
      });
    }
  }

})

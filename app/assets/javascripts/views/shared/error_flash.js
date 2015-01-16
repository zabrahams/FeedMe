FeedMe.Views.ErrorFlash = Backbone.View.extend({

  initialize: function () {
    this.listenTo(FeedMe.vent, "errorFlash", this.flashMessage.bind(this));
    this.listenTo(FeedMe.vent, "clearFlash", this.clearFlash.bind(this));
  },

  tagName: "section",

  className: "flash error-flash closed",

  template: JST['shared/error_flash'],

  render: function () {
    this.$el.html(this.template());
    return this;
  },

  flashMessage: function (msg) {

    if (Array.isArray(msg)) {
      msg = msg.join("<br>");
    }
    this.$(".message").html(msg);
    this.$el.removeClass("closed");
  },

  clearFlash: function () {
    if (!this.$el.hasClass("closed")) {
      this.$(".message").empty();
      this.$el.addClass("closed");
    }
  }

});

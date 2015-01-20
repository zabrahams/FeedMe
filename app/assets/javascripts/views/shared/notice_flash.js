FeedMe.Views.NoticeFlash = Backbone.View.extend({

  initialize: function () {
    this.listenTo(FeedMe.vent, "noticeFlash", this.flashMessage.bind(this));
    this.listenTo(FeedMe.vent, "clearFlash", this.clearFlash.bind(this));
  },

  tagName: "section",

  className: "flash notice-flash closed",

  template: JST['shared/notice_flash'],

  render: function () {
    this.$el.html(this.template());
    return this;
  },

  flashMessage: function (msg) {
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

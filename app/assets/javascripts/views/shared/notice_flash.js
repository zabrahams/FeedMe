FeedMe.Views.NoticeFlash = Backbone.View.extend({

  initialize: function () {
    this.listenTo(FeedMe.vent, "noticeFlash", this.flashMessage.bind(this));
    this.listenTo(FeedMe.vent, "clearFlash", this.clearFlash.bind(this));
  },

  tagName: "section",

  className: "flash notice-flash",

  template: JST['shared/notice_flash'],

  render: function () {
    this.$el.html(this.template());
    return this;
  },

  flashMessage: function (msg) {
    console.log(msg);
    this.$(".message").html(msg);
  },

  clearFlash: function () {
    this.$(".message").empty();
  }

});

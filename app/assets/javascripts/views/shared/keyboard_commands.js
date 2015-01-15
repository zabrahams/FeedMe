FeedMe.Views.KeyboardCommands = Backbone.View.extend({

  tagName: "section",

  className: "modal-container closed",

  events: {
    "click button.close-modal": "closeModal"
  },

  template: JST["shared/keyboard_map"],

  render: function () {
    this.$el.html(this.template());
    return this;
  },

  closeModal: function () {
    $(".modal-container").addClass("closed");
  }

});

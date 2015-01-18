FeedMe.Views.SessionPassword = Backbone.View.extend({

  events: {
    "submit form": "getQuestions"
  },

  template: JST['sessions/password'],

  questTemplate: JST['sessions/questions'],

  render: function () {
    this.$el.html(this.template());
    return this;
  },

  getQuestions: function (event) {
    var $form, attrs, userQuestions;

    event.preventDefault();
    $form = this.$("form");
    attrs = $form.serializeJSON();

    console.log(attrs);

    userQuestions = new FeedMe.Collections.SecurityQuestions();
    userQuestions.fetch({
      data: attrs,
      dataType: "json",
      success: function () {
        this.questionsForm(userQuestions);
      }.bind(this),
      error: function () {
        console.log("Couldn't find the questions.")
      }
    });
  },

  questionsForm: function (userQuestions) {
    this.$el.append(this.questTemplate( {questions: userQuestions }));
  }

});

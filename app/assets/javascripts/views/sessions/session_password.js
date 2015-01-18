FeedMe.Views.SessionPassword = Backbone.View.extend({

  events: {
    "submit form#email-form": "getQuestions",
    "submit form#security_question_form": "resetPassword"
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
    $form = $(event.currentTarget);
    attrs = $form.serializeJSON();

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
    console.log(userQuestions.first().get('user_id'));
    this._userId = userQuestions.first().get('user_id')
    this.$el.append(this.questTemplate( {questions: userQuestions.first().get("questions") }));
  },

  resetPassword: function (event) {

    event.preventDefault();
    $form = $(event.currentTarget);
    attrs = $form.serializeJSON();
    $.ajax({
      url: "api/users/" + this._userId + "/reset",
      type: "POST",
      data: attrs,
      dataType: "json",
      success: function () {
        console.log("Success!");
      },
      error: function () {
        console.log("Failure!");
      }
    });
  }

});

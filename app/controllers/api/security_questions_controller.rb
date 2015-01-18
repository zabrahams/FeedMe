class Api::SecurityQuestionsController < ApplicationController

  skip_before_action :require_login

  def index
    if params[:user] && params[:user][:email]
      @user = User.find_by(email: params[:user][:email])
      if @user
        @questions = @user.security_questions
        render :index
      else
        render json: {errors: "Could not find a user with that email"}
      end
    else
      @questions = SecurityQuestion.all
      render :index
    end
  end

end

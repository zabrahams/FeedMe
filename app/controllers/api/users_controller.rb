class Api::UsersController < ApplicationController
  wrap_parameters false

  skip_before_action :require_login, only: [:create, :activation, :reset_email, :reset]
  before_action :require_ownership, only: :update

  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def create
    check_password_confirmation
    @user = User.new(user_params)

    @user.security_question_answers.new(
      question_id: params[:user][:sec_question_1],
      answer: params[:user][:sec_answer_1]
    )
    @user.security_question_answers.new(
      question_id: params[:user][:sec_question_2],
      answer: params[:user][:sec_answer_2]
    )

    if (params[:user][:password] != params[:user][:password_confirmation])
        render json: {errors: "Password does not match Password Confirmation"}, status: :unprocessable_entity
    elsif @user.save

      AuthMailer.signup_email(@user).deliver
      render json: {notice: "You have successfully created an account. Please click on the link in your email to activate this account."}
      login(@user)
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    params[:user][:password] = nil if params[:user][:password] === ""
    params[:user][:password_confirmation] = nil if params[:user][:password_confirmation] === ""
    if  @user.update(user_params) && check_password_confirmation
      render :show
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def personal_feed
    @user = User.find(params[:id])
    render text: @user.make_feed
  end

  def activation
    @user = User.find(params[:id])
      if @user.activation_token == params[:activation_token]
        @user.activated = true
        login(@user)
        redirect_to root_url
      else
        render json: {error: "We apolize but there is a problem with your authentication. Please try again. If you continue having difficulties, please email support@feed--me.herokuapp.com"}
      end
  end

  def reset_email
    @user = User.find(params[:id])
    if @user.verify_security_questions(
      params[:user][:question_0],
      params[:user][:answer_0],
      params[:user][:question_1],
      params[:user][:answer_1]
    )
      @user.set_reset_token
      AuthMailer.password_email(@user).deliver
      render json: {notice: "We have sent you a password reset email. Click the link in the email to reset your password."}
    else
      render json: {errors: "You did not answer the security questions correctly."}, status: :unprocessable_entity
    end
  end

  def reset
    @user = User.find(params[:id])
    if !@user
      render json: {errors: "Cannot find that user"}, status: :unprocessable_entity
    elsif @user.has_reset_token?(params[:reset_token])
      @user.clear_reset_token
      login(@user)
      redirect_to "/#/users/edit"
    else
      render json: {errors: "Link contained the wrong reset token"}, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:fname,
                                 :lname,
                                 :email,
                                 :description,
                                 :image,
                                 :username,
                                 :password)
  end

  def require_ownership
    unless current_user.id.to_s == params[:id]
      render json: {errors: "You cannot edit another user's profile. Not cool."}
    end
  end

  def check_password_confirmation
    if (params[:user][:password] != params[:user][:password_confirmation])
      @user.errors.add(:password, "does not match Password Confirmation")
      false
    else
      true
    end
  end

end

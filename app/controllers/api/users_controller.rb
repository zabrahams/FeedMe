class Api::UsersController < ApplicationController
  wrap_parameters false

  skip_before_action :require_login, only: [:create, :activation]
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
    @user = User.new(user_params)
    if (params[:user][:password] != params[:user][:password_confirmation])
        render json: {errors: "Password does not match Password Confirmation"}
    elsif @user.save
      AuthMailer.signup_email(@user).deliver
      render json: {notice: "You have successfully created an account. Please click on the link in your activation email to login."}
    else
      render json: @user.errors.full_messages
    end
  end

  def update
    params[:user][:password] = nil if params[:user][:password] === ""

    if (params[:user][:password] != params[:user][:password_confirmation]) &&
      !params[:user][:password].nil?
    @user = User.find(params[:id])
      render json: {errors: "Password does not match Password  Confirmation"}
    elsif  @user.update(user_params)
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

end

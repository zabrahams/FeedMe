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
    check_password_confirmation
    @user = User.new(user_params)
    if @user.save
      AuthMailer.signup_email(@user).deliver
      render json: {notice: "You have successfully created an account. Please click on the link in your activation email to login."}
    else
      render :errors, status: :unprocessable_entity
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
        render text: "We apolize but there is a problem with your authentication. Please try again. If you continue having difficulties, please email support@feed--me.herokuapp.com"
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

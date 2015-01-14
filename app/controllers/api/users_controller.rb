class Api::UsersController < ApplicationController
  wrap_parameters false

  before_action :require_login, only: :update
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
      render json: {notice: "You have successfully created an account."}
    else
      render json: @user.errors.full_messages
    end
  end

  def update
    @user = User.find(params[:id])
    params[:user][:password] = nil if params[:user][:password] === ""

    if (params[:user][:password] != params[:user][:password_confirmation]) &&
      !params[:user][:password].nil?
      render json: {errors: "Password does not match Password  Confirmation"}
    elsif  @user.update(user_params)
      render :show
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
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

class Api::SessionsController < ApplicationController
  wrap_parameters false

  skip_before_action :require_login, only: [:show, :create]

  def show
    if current_user
      @user = current_user
      render 'api/users/show'
    else
      render json: {notice: "Please log in."}
    end
  end

  def create
    @user = User.find_by_credentials(params[:user][:username],
    params[:user][:password])
    if @user && @user.activated
      login(@user)
      @user.notice = "You are now logged in."
      render json: @user;
    elsif @user
      render json: {errors: "Please activate your account before logging in."},
             status: :unprocessable_entry
    else
      render json: {errors: "Invalid Username/Password."},
             status:  :unprocessable_entry
    end
  end

  def destroy
    logout
    render json: {notice: "You are logged out."}
  end
end

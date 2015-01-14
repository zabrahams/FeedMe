class Api::SessionsController < ApplicationController
  wrap_parameters false

  skip_before_action :require_login, only: [:show, :create]

  def show
    if current_user
      render json: @current_user;
    else
      render json: {errors: "Problem logging in."}
    end
  end

  def create
    @user = User.find_by_credentials(params[:user][:username],
    params[:user][:password])
    if @user
      login(@user)
      render json: @user;
    else
      render json: {errors: "Invalid Username/Password."}
    end
  end

  def destroy
    logout
    render json: {notice: "You are logged out."}
  end
end

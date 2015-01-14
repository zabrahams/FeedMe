class Api::SessionsController < ApplicationController
  wrap_parameters false

  skip_before_action :require_login, only: [:new, :create]

  def create
    @user = User.find_by_credentials(params[:user][:username],
    params[:user][:password])
    if @user
      login(@user)
      render json: {notice: "Welcome Back."}
    else
      render json: {errors: "Invalid Username/Password."}
    end
  end

  def destroy
    logout
    render json: {notice: "You are logged out."}
  end
end

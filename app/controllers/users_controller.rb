class UsersController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]
  before_action :require_ownership, only: [:edit, :update]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if params[:user][:password] != params[:user][:password_confirmation]
      flash[:errors] = ["Password does not match Password Confirmation"]
      render :new
    elsif @user.save
      login(@user)
      redirect_to feeds_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:password] != params[:user][:password_confirmation]
      flash.now[:errors] = ["Password does not match Password Confirmation"]
      render :edit
    elsif @user.update(user_params)
      redirect_to feeds_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:username,
                                 :email,
                                :password)
  end

  def require_ownership
    unless params[:id] == current_user.id.to_s
      flash[:errors] = ["You cannot access that page."]
      redirect_to user_url(current_user)
    end
  end

end

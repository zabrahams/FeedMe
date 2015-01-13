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

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render :show
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:fname, :lname, :email, :description, :image)
  end

  def require_ownership
    unless current_user.id.to_s == params[:id]
      render json: {errors: "You cannot edit another user's profile. Not cool."}
    end
  end

end

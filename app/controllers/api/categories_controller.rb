class Api::CategoriesController < ApplicationController

  before_action :set_category, only: [:show, :update, :destroy]
  before_action :require_ownership, only: [:show, :update, :destroy]

  def index
    @categories = current_user.categories
    render :index
  end

  def show
    @category.feeds.each { |feed| feed.update_entries! } # Remove bang for production
    @entries = @category.entries.includes(:feed).order(published_at: :desc)
    render :show
  end

  def create
    @category = current_user.categories.new(name: params[:category][:name])
    if @category.save
      render :show
    else
      render json: @category.errors.full_messages, status: :unprocessable_entity
    end
  end


  # def update
  #   if @category.update(category_params)
  #     redirect_to category_url(@category)
  #   else
  #     flash.now[:errors] = @category.errors.full_messages
  #     render :edit
  #   end
  # end

  def destroy
    @category.destroy
    render json: {}
  end

  private

  def category_params
    params.require(:category).permit(:name, :feed_name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def require_ownership
    if @category.user_id != current_user.id
      flash[:errors] = ["That category belongs to a different user."]
      redirect_to categories_url
    end
  end

end

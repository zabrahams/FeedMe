class CategoriesController < ApplicationController

  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :require_ownership, only: [:show, :edit, :update, :destroy]

  def index
    @categories = current_user.categories
    render :index
  end

  def show
    render :show
  end


  def new
    @category = Category.new
    render :new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to category_url(@category)
    else
      flash.now[:errors] = @category.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @category.update(category_params)
      redirect_to category_url(@category)
    else
      flash.now[:errors] = @category.errors.full_messages
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_url
  end

  private

  def category_params
    params.require(category).permit(:name)
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

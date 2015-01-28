class Api::CategoriesController < ApplicationController

  wrap_parameters false

  before_action :set_category, only: [:show, :update, :destroy]
  before_action :require_ownership, only: [:show, :update, :destroy]

  def index
    @categories = current_user.categories.includes(:feeds)
    render :index
  end

  def show
    @category.feeds.each do |feed|
      if feed.need_update? && !feed.curated
        Resque.enqueue(UpdateEntries, feed.id)
      end
    end

    @entries = @category
      .entries
      .includes(:feeds)
      .order(published_at: :desc)
      .page(params[:page])
      .per(40)
      if params[:page] && params[:page].to_i > @entries.total_pages
        render json: {errors: "All entries sent.",
          total_pages: @entries.total_pages}, status: :unprocessable_entity
      else
        render :show
      end
  end

  def create
    @category = current_user.categories.new(name: params[:category][:name])
    if @category.save
      render :show
    else
      render json: @category.errors.full_messages, status: :unprocessable_entity
    end
  end


  def update
    if @category.update(category_params)
      @category.feeds.delete_all if params[:category][:feed_ids].nil?
      @categories = current_user.categories.includes(:feeds)
      render :index
    else
      render json: @category.errors.full_messages
    end
  end

  def destroy
    @category.destroy
    render json: {}
  end

  private

  def category_params
    params.require(:category).permit(:name, feed_ids: [])
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

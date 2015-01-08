class FeedsController < ApplicationController

  def index
    @feeds = current_user.feeds

    render :index
  end

  def new
    @feed = Feed.new
    render :new
  end

  def create
    @feed = Feed.find_by(url: params[:feed][:url])
    if @feed
      current_user.feeds << @feed
      redirect_to feeds_url
    elsif current_user.feeds.create(set_url: params[:feed][:url])
      redirect_to feeds_url
    else
      flash.now[:errors] = ["Problem creating feed!"]
      render :new
    end
  end

  def show
    @feed = Feed.find(params[:id])
    if current_user.feeds.include?(@feed)
      @feed.update_entries!  # remove bang for production
      @entries = @feed.entries.order(published_at: :desc)
      render :show
    else
      flash[:errors] = ["You don't subscribe to that feed."]
      redirect_to feeds_url
    end
  end

end

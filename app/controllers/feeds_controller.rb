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
      flash[:errors] = ["Problem creating feed!"]
      render :new
    end
  end

end

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
  end

  private

  def feed_params
    params.require(:feed).permit(:url, :name)
  end

end

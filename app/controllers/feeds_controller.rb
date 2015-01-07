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
    @feed = Feed.find_by(url: params[:feed][:url],
                         name: params[:feed][:name])
    if @feed
      current_user.feeds << @feed
      redirect_to feeds_url
    else
      if current_user.feeds.create(feed_params)
        redirect_to feeds_url
      else
        flash[:errors] = ["Problem creating feed!"]
        render :new
      end
    end
  end

  private

  def feed_params
    params.require(:feed).permit(:url, :name)
  end

end

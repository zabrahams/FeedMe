class Api::FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :remove]
  before_action :require_subscription, only: [:show, :remove]

  def index
    @feeds = current_user.feeds
    render :index
  end

  def create
    @feed = Feed.find_or_create_by(url: params[:feed][:url])
    if @feed.persisted?
      current_user.feeds << @feed
      render json: @feed
    else
      render json: @feed.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    @feed.update_entries!  # remove bang for production
    @entries = @feed.entries.order(published_at: :desc)
    render :show
  end

  # def remove
  #   if @feed.user_feeds.size == 1
  #     @feed.destroy
  #   else
  #     current_user.feeds.delete(@feed)
  #   end
  #   render @feed
  # end

  private

  def set_feed
    @feed = Feed.find(params[:id])
  end

  def require_subscription
    unless current_user.feeds.include?(@feed)
      flash[:errors] = ["You don't subscribe to that feed."]
      redirect_to feeds_url
    end
  end

end

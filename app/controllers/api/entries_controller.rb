class Api::EntriesController < ApplicationController

  def index
    current_user.feeds.each { |feed| feed.update_entries! }  # remove bang for production
    @entries = current_user.entries.includes(:feed).order(published_at: :desc)
    render :index
  end

  def show
    @entry = Entry.find(params[:id])
    if current_user.entries.include?(@entry)
      current_user.read_entries << @entry
      render :show
    else
      render json: "{'errors': 'You don't subscribe to that feed.'}"
    end
  end

  def recent
    @entries = current_user.read_entries.includes(:feed).order(published_at: :desc)
    render :index
  end

end

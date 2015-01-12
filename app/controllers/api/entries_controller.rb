class Api::EntriesController < ApplicationController

  def index
    current_user.feeds.each { |feed| Resque.enqueue(UpdateEntries, feed.id) }  # remove bang for production
    @entries = current_user.entries.includes(:feed).order(published_at: :desc)
    render :index
  end

  def read
    @entry = Entry.find(params[:id])
    unless current_user.read_entries.include?(@entry)
      current_user.read_entries << @entry
    end

    render json: @entry
  end

  def recent
    @entries = current_user.read_entries.includes(:feed).order(published_at: :desc)
    render :index
  end

end

class Api::EntriesController < ApplicationController

  def index
    @feeds = current_user.feeds
    @feeds.each do |feed|
      if feed.updated_at < 30.seconds.ago
        Resque.enqueue(UpdateEntries, feed.id)
      end
    end
    @entries = current_user.entries.includes(:feed).order(published_at: :desc)
    render :index
  end

  def read
    @entry = Entry.find(params[:id])
    current_user.read_entry(@entry)

    render json: @entry
  end

  def recent
    @entries = current_user.read_entries.includes(:feed).order(published_at: :desc)
    render :recent
  end

end

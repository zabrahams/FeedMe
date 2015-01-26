class Api::EntriesController < ApplicationController

  def index
    @feeds = current_user.feeds
    @feeds.each do |feed|
      if feed.updated_at < 30.seconds.ago && !feed.curated
        Resque.enqueue(UpdateEntries, feed.id)
      end
    end
    @entries = current_user
      .entries
      .includes(:feeds)
      .order(published_at: :desc)
      .page(params[:page])
    render :index
  end

  def read
    @entry = Entry.find(params[:id])
    current_user.read_entry(@entry)

    render json: @entry
  end

  def recent
    @entries = current_user.curated_feed.entries.includes(:feeds).order(published_at: :desc)
    render :recent
  end

end

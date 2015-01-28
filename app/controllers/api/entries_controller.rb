class Api::EntriesController < ApplicationController

  def index
    @feeds = current_user.feeds
    @feeds.each do |feed|
      if feed.need_update? && !feed.curated
        Resque.enqueue(UpdateEntries, feed.id)
      end
    end
    @entries = current_user
      .entries
      .includes(:feeds)
      .order(published_at: :desc)
      .page(params[:page])
      .per(40)

    if params[:page] && params[:page].to_i > @entries.total_pages
      render json: {errors: "All entries sent.",
                    total_pages: @entries.total_pages}, status: :unprocessable_entity
    else
      render :index
    end
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

class EntriesController < ApplicationController

  def show
    @entry = Entry.find(params[:id])
    if current_user.entries.include?(@entry)
      render :show
    else
      flash[:errors]  = ["You don't subscribe to that feed."]
      redirect_to feeds_url
    end
  end

end

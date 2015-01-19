class Api::CommentsController < ApplicationController

  def index
    model = params[:commentable][:type].constantize
    @commentable = model.find(params[:commentable][:id])
    @comments = @commentable.comments.includes(:author)
    render :index
  end

end

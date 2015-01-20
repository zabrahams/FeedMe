class Api::CommentsController < ApplicationController

  def index
    model = params[:commentable][:type].constantize
    @commentable = model.find(params[:commentable][:id])
    @comments = @commentable.comments.includes(:author)
    render :index
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.is_about?(current_user) || @comment.is_by?(current_user)
      @comment.destroy
      render json: {notice: "You have deleted the comment."}
    else
      render json: {errors: "You do not have permission to delete this comment."},
      status: :unprocessable_entity
    end
  end

end

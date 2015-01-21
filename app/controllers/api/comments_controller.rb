class Api::CommentsController < ApplicationController

  def index
    model = params[:commentable][:type].constantize
    @commentable = model.find(params[:commentable][:id])
    @comments = @commentable.comments.includes(:author)
    render :index
  end

  def create
    @comment = Comment.new(comment_params)
    current_user.authored_comments << @comment
    if current_user.save
      render :show
    else
      render json: @comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      render :show
    else
      render json: @comment.errors.full_messages, status: :unprocessable_entity
    end
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

  def comment_params
    params.require(:comment).permit(:commentable_type, :commentable_id, :body)
  end

end

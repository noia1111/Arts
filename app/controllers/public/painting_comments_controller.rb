class Public::PaintingCommentsController < ApplicationController
  before_action :is_matching_comment, only: [:destroy]
  def create
    painting = Painting.find(params[:painting_id])
    comment = current_user.painting_comments.new(painting_comments_params)
    comment.painting_id = painting.id
    comment.save
    @painting.create_notification_comment!(current_user, @comment.id)

    redirect_to painting_path(painting)
  end

  def destroy
    @painting_comment = PaintingComment.find(params[:id])
    @painting_comment.destroy
    redirect_to painting_path(params[:painting_id])
  end

  private

  def painting_comments_params
    params.require(:painting_comment).permit(:comment)
  end
  
  def is_matching_comment
    user = PaintingComment.find(params[:id]).user
    unless user.id == current_user.id
      redirect_to root_path
    end
  end
end

class Admin::PaintingCommentsController < ApplicationController
  def create
    painting = Painting.find(params[:painting_id])
    comment = current_user.painting_comments.new(painting_comments_params)
    comment.painting_id = painting.id
    comment.save
    redirect_to painting_path(painting)
  end

  def destroy
    @painting_comment = PaintingComment.find(params[:painting_id])
    @painting_comment.destroy
    redirect_to admin_painting_path(params[:painting_id])
  end

  private

  def painting_comments_params
    params.require(:painting_comment).permit(:comment)
  end
end
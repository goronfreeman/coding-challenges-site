class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    @comment.challenge_id = params[:challenge_id]
    @comment.user_id = current_user.id

    @comment.save

    redirect_to challenge_path(@comment.challenge)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :challenge_id, :user_id)
  end
end

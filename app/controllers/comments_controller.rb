class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_comment, only: [:edit, :update, :destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.challenge_id = params[:challenge_id]
    @comment.user_id = current_user.id

    @comment.save

    redirect_to challenge_path(@comment.challenge)
  end

  def edit
    # TODO: redirect back to user profile if editing from that page
    redirect_to challenge_path(@challenge) unless @comment.user_id == current_user.id
  end

  def update
    if @comment.update(comment_params)
      redirect_to challenge_path(@challenge)
    else
      render :edit
    end
  end

  def destroy
    if @comment.user_id == current_user.id
      @comment.update_attribute :body, '[deleted]'
    end
    # TODO: redirect back to user profile if deleting from that page
    redirect_to challenge_path(@challenge)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_comment
    @challenge = Challenge.find(params[:challenge_id])
    @comment = Comment.find(params[:id])
  end
end

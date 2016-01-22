class ChallengesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_challenge, only: [:show, :edit, :update, :destroy]

  # Actions for difficulty index pages
  def easy
    @easy = Challenge.where('difficulty = 0')
  end

  def medium
    @medium = Challenge.where('difficulty = 1')
  end

  def hard
    @hard = Challenge.where('difficulty = 2')
  end

  # Standard actions
  def index
    @challenges = Challenge.all
  end

  def show
    @comment = Comment.new
    @comment.challenge_id = @challenge.id
  end

  def new
    @challenge = current_user.challenges.build
    @challenge_tags = @challenge.challenge_tags.build
  end

  def create
    @challenge = current_user.challenges.build(challenge_params)

    if @challenge.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @challenge_tags = @challenge.challenge_tags.build
    redirect_to root_path unless @challenge.user_id == current_user.id
  end

  def update
    if @challenge.update(challenge_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @challenge.destroy if @challenge.user_id == current_user.id
    redirect_to root_path
  end

  private

  def challenge_params
    params.require(:challenge).permit(
      :name, :short_description, :long_description, :user_id, :difficulty,
      challenge_tags_attributes: [:tag_id]
    )
  end

  def find_challenge
    @challenge = Challenge.find(params[:id])
  end
end

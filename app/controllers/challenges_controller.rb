class ChallengesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_challenge, only: [:show, :edit, :update, :destroy]

  def index
    @challenges = Challenge.all
  end

  def testing
    @challenge = current_user.challenges.build
  end

  def show
  end

  def new
    @challenge = current_user.challenges.build
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
    redirect_to root_path if @challenge.user_id != current_user.id
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
    params.require(:challenge).permit(:name, :short_description, :long_description, :user_id, :difficulty)
  end

  def find_challenge
    @challenge = Challenge.find(params[:id])
  end
end

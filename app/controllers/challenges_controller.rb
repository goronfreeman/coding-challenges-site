class ChallengesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @challenges = Challenge.all
    respond_to do |format|
      format.html
      format.json { render json: @challenges }
    end
  end

  def show
    @challenge = Challenge.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @challenge }
    end
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
    @challenge = Challenge.find(params[:id])
  end

  def update
    @challenge = Challenge.find(params[:id])

    if @challenge.update(challenge_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @challenge = Challenge.find(params[:id])

    if @challenge.user_id == current_user.id
      @challenge.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def challenge_params
    params.require(:challenge).permit(:name, :short_description, :long_description, :user_id, :difficulty)
  end
end

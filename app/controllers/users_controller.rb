class UsersController < ApplicationController
  before_action :find_user

  def show
  end

  def comments
  end

  def submitted
  end

  def starred
  end

  def completed
  end

  private

  def find_user
    @user = User.find_by(username: params[:username])
  end
end

class UsersController < ApplicationController
  def authorize
    address = github.authorize_url scope: 'user, gist'
    redirect_to address
  end

  def callback
    authorization_code = params[:code]
    access_token = github.get_token authorization_code
    current_user.update_attributes(github_token: access_token.token)

    github = Github.new oauth_token: current_user.github_token
    username = github.users.get.login
    avatar_url = github.users.get.avatar_url
    current_user.update_attributes(username: username, avatar_url: avatar_url )
    
    redirect_to root_path
  end

  private

  def github
    @github ||= Github.new client_id: ENV['CLIENT_ID'], client_secret: ENV['CLIENT_SECRET']
  end
end

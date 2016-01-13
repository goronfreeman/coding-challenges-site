class UsersController < ApplicationController
  def authorize
    address = github.authorize_url scope: 'user:email, gist'
    redirect_to address
  end

  def callback
    authorization_code = params[:code]
    access_token = github.get_token authorization_code
    current_user.update_attributes(github_token: access_token.token)

    github = Github.new oauth_token: current_user.github_token
    username = github.users.get.login
    avatar_url = github.users.get.avatar_url
    email = github.users.get.email

    current_user.update_attributes(email: email, username: username, avatar_url: avatar_url )

    redirect_to root_path
  end

  private

  def github
    @github ||= Github.new client_id: ENV['CLIENT_ID'], client_secret: ENV['CLIENT_SECRET']
  end
end

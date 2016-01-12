class AddGithubInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :github_token, :string
    add_column :users, :username, :string
    add_column :users, :avatar_url, :string
  end
end

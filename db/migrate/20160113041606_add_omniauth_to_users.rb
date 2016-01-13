class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_index :users, :provider
    add_column :users, :uid, :string
    add_index :users, :uid

    remove_column :users, :github_token
    remove_column :users, :avatar_url

    add_column :users, :image, :string
  end
end

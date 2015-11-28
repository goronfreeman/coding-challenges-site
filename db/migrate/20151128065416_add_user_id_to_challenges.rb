class AddUserIdToChallenges < ActiveRecord::Migration
  def change
    add_reference :challenges, :user
  end
end

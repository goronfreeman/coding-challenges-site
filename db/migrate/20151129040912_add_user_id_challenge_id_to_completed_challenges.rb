class AddUserIdChallengeIdToCompletedChallenges < ActiveRecord::Migration
  def change
    remove_column :completed_challenges, :id
    add_reference :completed_challenges, :user
    add_reference :completed_challenges, :challenge
  end
end

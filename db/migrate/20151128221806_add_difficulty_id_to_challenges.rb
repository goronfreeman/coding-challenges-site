class AddDifficultyIdToChallenges < ActiveRecord::Migration
  def change
    remove_column :challenges, :difficulty
    add_reference :challenges, :difficulty
  end
end

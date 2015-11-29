class AddDifficultyToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :difficulty, :integer, default: 0
    remove_column :challenges, :difficulty_id
  end
end

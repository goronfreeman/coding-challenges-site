class AddDifficultyToChallenge < ActiveRecord::Migration
  def change
    add_column :challenges, :difficulty, :integer
  end
end

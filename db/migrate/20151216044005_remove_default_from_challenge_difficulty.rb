class RemoveDefaultFromChallengeDifficulty < ActiveRecord::Migration
  def change
    change_column_default(:challenges, :difficulty, nil)
  end
end

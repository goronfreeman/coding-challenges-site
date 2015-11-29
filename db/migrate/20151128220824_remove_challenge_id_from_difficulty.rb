class RemoveChallengeIdFromDifficulty < ActiveRecord::Migration
  def change
    remove_column :difficulties, :challenge_id
  end
end

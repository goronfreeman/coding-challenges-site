class AddChallengeIdToDifficulty < ActiveRecord::Migration
  def change
    add_reference :difficulties, :challenge
  end
end

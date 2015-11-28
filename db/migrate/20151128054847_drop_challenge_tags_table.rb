class DropChallengeTagsTable < ActiveRecord::Migration
  def change
    drop_table :challenge_tags
  end
end

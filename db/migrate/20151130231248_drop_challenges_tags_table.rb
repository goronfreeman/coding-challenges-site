class DropChallengesTagsTable < ActiveRecord::Migration
  def change
    drop_table :challenges_tags
  end
end

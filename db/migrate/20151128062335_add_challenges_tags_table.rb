class AddChallengesTagsTable < ActiveRecord::Migration
  def change
    create_table :challenges_tags, id: false do |t|
      t.belongs_to :challenge, index: true
      t.belongs_to :tag, index: true
    end
  end
end

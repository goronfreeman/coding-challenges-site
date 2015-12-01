class CreateChallengeTags < ActiveRecord::Migration
  def change
    create_table :challenge_tags do |t|
      t.references :challenge, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

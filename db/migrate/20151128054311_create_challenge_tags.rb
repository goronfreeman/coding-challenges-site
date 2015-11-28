class CreateChallengeTags < ActiveRecord::Migration
  def change
    create_table :challenge_tags do |t|

      t.timestamps null: false
    end
  end
end

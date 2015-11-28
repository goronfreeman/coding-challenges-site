class CreateCompletedChallenges < ActiveRecord::Migration
  def change
    create_table :completed_challenges do |t|

      t.timestamps null: false
    end
  end
end

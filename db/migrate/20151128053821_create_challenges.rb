class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :name
      t.text :short_description
      t.text :long_description

      t.timestamps null: false
    end
  end
end

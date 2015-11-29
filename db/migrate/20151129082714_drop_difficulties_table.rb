class DropDifficultiesTable < ActiveRecord::Migration
  def change
    drop_table :difficulties
  end
end

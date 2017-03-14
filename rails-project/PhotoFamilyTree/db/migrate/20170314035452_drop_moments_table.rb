class DropMomentsTable < ActiveRecord::Migration[5.0]
  def change
      drop_table :moments
  end
end

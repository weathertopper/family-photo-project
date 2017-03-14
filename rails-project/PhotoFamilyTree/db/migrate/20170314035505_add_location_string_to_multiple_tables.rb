class AddLocationStringToMultipleTables < ActiveRecord::Migration[5.0]
  def change
      add_column :photos, :location, :string
      add_column :events, :location, :string
      add_column :memories, :location, :string
  end
end

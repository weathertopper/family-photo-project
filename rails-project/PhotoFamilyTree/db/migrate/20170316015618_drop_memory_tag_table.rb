class DropMemoryTagTable < ActiveRecord::Migration[5.0]
  def change
      drop_table :memory_tags
  end
end

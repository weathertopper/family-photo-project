class DropEventTagsTable < ActiveRecord::Migration[5.0]
  def change
      drop_table :event_tags
  end
end

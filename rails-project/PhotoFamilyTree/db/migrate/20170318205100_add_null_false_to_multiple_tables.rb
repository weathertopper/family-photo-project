class AddNullFalseToMultipleTables < ActiveRecord::Migration[5.0]
  def change
      change_column_null :event_tags, :event_id, false
      change_column_null :event_tags, :relative_id, false
      change_column_null :photo_tags, :photo_id, false
      change_column_null :photo_tags, :relative_id, false
  end
end

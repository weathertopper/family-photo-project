class RenameTypeIdToEventTypeReference < ActiveRecord::Migration[5.0]
  def change
      rename_column :events, :type_id, :event_type_reference
  end
end

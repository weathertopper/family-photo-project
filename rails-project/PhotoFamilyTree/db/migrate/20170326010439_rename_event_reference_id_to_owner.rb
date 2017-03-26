class RenameEventReferenceIdToOwner < ActiveRecord::Migration[5.0]
  def change
      rename_column :events, :event_type_reference, :event_owner_id
  end
end

class RenameMomentTagsToEvenTags < ActiveRecord::Migration[5.0]
  def change
      rename_table :moment_tags, :event_tags
  end
end

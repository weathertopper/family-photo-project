class RenamePhotographerToPoster < ActiveRecord::Migration[5.0]
  def change
      add_reference :photos, :poster, references: :relatives, index: true
      add_foreign_key :photos, :relatives, column: :poster_id

      remove_column :photos, :photographer_id, :index

  end
end

class AddPhotographerToPhotos < ActiveRecord::Migration[5.0]
  def change
      add_reference :photos, :photographer, references: :relatives, index: true
      add_foreign_key :photos, :relatives, column: :photographer_id
  end
end

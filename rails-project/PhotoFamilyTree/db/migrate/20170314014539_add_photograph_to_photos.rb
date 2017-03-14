class AddPhotographToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :photograph, :string
  end
end

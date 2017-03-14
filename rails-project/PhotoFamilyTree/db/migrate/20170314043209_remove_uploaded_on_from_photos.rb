class RemoveUploadedOnFromPhotos < ActiveRecord::Migration[5.0]
  def change
      remove_column :photos, :uploaded_on, :date
  end
end

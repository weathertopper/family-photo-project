class AddWidthHeightToPhoto < ActiveRecord::Migration[5.0]
  def change
      rename_column :relatives, :profile_photo_width, :photo_width
      rename_column :relatives, :profile_photo_height, :photo_height

      add_column :photos, :photo_width, :integer
      add_column :photos, :photo_height, :integer
  end
end

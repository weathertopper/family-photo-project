class AddProfilePhotoWidthHeightToRelative < ActiveRecord::Migration[5.0]
  def change
      add_column :relatives, :profile_photo_width, :integer
      add_column :relatives, :profile_photo_height, :integer
  end
end

class AddProfilePhotoToRelatives < ActiveRecord::Migration[5.0]
  def change
    add_column :relatives, :profile_photo, :string
  end
end

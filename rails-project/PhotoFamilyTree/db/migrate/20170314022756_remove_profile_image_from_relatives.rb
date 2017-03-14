class RemoveProfileImageFromRelatives < ActiveRecord::Migration[5.0]
  def change
    remove_column :relatives, :profile_image, :string
  end
end

class CreatePhotoTags < ActiveRecord::Migration[5.0]
  def change
    create_table :photo_tags do |t|
        t.belongs_to :photo, index: true
        t.belongs_to :relative, index: true
        t.timestamps
    end
  end
end

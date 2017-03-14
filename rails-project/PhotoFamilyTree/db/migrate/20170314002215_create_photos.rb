class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
        t.date 'taken_on'
        t.date 'uploaded_on'
        t.string 'header'
        t.string 'caption'
        t.timestamps
    end
  end
end

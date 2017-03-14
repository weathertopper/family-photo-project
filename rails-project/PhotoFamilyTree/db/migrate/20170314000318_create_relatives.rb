class CreateRelatives < ActiveRecord::Migration[5.0]
    def change
    create_table :relatives do |t|
        t.string 'first'
        t.string 'middle'
        t.string 'maiden'
        t.string 'surname'
        t.string 'nickname'
        t.string 'sex'
        t.date 'birthday'
        t.date 'deathday'
        t.string 'profile_image'
        t.timestamps
    end
  end
end

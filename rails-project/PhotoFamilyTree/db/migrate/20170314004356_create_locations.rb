class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
        # I willingly assume most of these locations will be w/in the US
        t.string "address"
        t.string "city"
        t.string "state"
        t.string "country"
        t.timestamps
    end
  end
end

class CreateMoments < ActiveRecord::Migration[5.0]
  def change
    create_table :moments do |t|
        t.date 'when'
        t.string 'content'
        t.timestamps
    end
  end
end

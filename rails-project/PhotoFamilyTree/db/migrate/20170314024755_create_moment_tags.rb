class CreateMomentTags < ActiveRecord::Migration[5.0]
  def change
    create_table :moment_tags do |t|

      t.timestamps
    end
  end
end

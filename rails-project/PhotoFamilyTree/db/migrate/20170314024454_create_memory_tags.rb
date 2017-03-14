class CreateMemoryTags < ActiveRecord::Migration[5.0]
  def change
    create_table :memory_tags do |t|
        t.belongs_to :memory, index: true
        t.belongs_to :relative, index: true
        t.timestamps
    end
  end
end

class CreateEventTagsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :event_tags do |t|
        t.belongs_to :event, index: true
        t.belongs_to :relative, index: true
        t.timestamps
    end
  end
end

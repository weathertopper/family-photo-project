class AddBelongsToToEventTags < ActiveRecord::Migration[5.0]
  def change
      add_reference :event_tags, :events, index: true
      add_reference :event_tags, :relatives, index: true
  end
end

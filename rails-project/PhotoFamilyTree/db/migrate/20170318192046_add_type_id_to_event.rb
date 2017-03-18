class AddTypeIdToEvent < ActiveRecord::Migration[5.0]
  def change
      # if type is not null, than the event is either a birth, a death, a marriage_start, or a marriage_end
      # these are the calculated types of events
      # in the former two, type_id references a Relative
      # in the latter two, type_id references a MarriageBranch
      # this is how 'update' will know what event to, you know, update
      add_column :events, :type_id, :integer
  end
end

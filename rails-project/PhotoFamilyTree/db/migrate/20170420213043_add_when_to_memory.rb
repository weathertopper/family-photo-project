class AddWhenToMemory < ActiveRecord::Migration[5.0]
  def change
      add_column :memories, :when, :date
  end
end

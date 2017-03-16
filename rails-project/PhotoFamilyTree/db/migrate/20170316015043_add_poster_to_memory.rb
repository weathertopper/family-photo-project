class AddPosterToMemory < ActiveRecord::Migration[5.0]
  def change
      add_reference :memories, :poster, references: :relatives, index: true
      add_foreign_key :memories, :relatives, column: :poster_id
  end
end

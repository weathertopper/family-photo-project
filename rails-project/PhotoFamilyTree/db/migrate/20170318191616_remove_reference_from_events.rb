class RemoveReferenceFromEvents < ActiveRecord::Migration[5.0]
  def change
      remove_reference :events, :subject, references: :relatives
  end
end

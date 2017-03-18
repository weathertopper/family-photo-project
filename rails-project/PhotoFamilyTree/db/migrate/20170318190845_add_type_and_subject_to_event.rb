class AddTypeAndSubjectToEvent < ActiveRecord::Migration[5.0]
  def change
      add_column :events, :type, :string #either birth, death, or marriage (ie calculated) or null (for implicit )

     #only for births and deaths, all other events have no 1 subject
      add_reference :events, :subject, references: :relatives, index: true
      add_foreign_key :events, :relatives, column: :subject_id
  end
end

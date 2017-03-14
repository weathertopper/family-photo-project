class CreateMarriageBranches < ActiveRecord::Migration[5.0]
  def change
    create_table :marriage_branches do |t|
        t.integer "husband_id", :null => false
        t.integer "wife_id", :null => false
        t.date "anniversary"
        t.date "separated_on"
        t.timestamps
    end
  end
end

class RenameSeparationInMarriageTable < ActiveRecord::Migration[5.0]
  def change
      rename_column :marriage_branches, :separated_on, :end
  end
end

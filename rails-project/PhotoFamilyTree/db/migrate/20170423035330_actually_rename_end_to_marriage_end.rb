class ActuallyRenameEndToMarriageEnd < ActiveRecord::Migration[5.0]
    def change
        rename_column :marriage_branches, :end, :marriage_end
    end
end

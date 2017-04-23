class RenameEndToMarriageEnd < ActiveRecord::Migration[5.0]
  def change
      def change
          rename_column :marriage_branches, :end, :marriage_end
      end
  end
end

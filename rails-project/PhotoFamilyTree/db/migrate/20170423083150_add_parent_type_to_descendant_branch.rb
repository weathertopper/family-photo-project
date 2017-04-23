class AddParentTypeToDescendantBranch < ActiveRecord::Migration[5.0]
  def change
       add_column :descendant_branches, :parent_type, :string
  end
end

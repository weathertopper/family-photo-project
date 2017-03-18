class AddSuffixToRelative < ActiveRecord::Migration[5.0]
  def change
      add_column :relatives, :suffix, :string
  end
end

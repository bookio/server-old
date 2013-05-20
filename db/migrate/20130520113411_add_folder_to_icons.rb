class AddFolderToIcons < ActiveRecord::Migration
  def change
    add_column :icons, :folder, :string, {:default => "", :null => false}
  end
end

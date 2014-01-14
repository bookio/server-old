class RemoveStuffFromIcons < ActiveRecord::Migration

  def up
    remove_column :icons, :folder
    remove_column :icons, :name
	rename_column :icons, :tags, :tag    
  end

  def down
    add_column :icons, :folder, :string
    add_column :icons, :name, :string
	rename_column :icons, :tag, :tags    
  end

end

class RemoveTypeFromIcons < ActiveRecord::Migration
  def up
    remove_column :icons, :type
  end

  def down
    add_column :icons, :type, :string
  end
end

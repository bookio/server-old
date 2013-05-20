class AddTypeToIcons < ActiveRecord::Migration
  def change
    add_column :icons, :type, :string, {:default => "", :null => false}
  end
end

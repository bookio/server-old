class ChangeNameInGroups < ActiveRecord::Migration
  def up
    change_column :groups, :name, :string, {:default => "", :null => false}
  end

  def down
    change_column :groups, :name, :string, {:null => true}
  end
end

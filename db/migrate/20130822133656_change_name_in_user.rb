class ChangeNameInUser < ActiveRecord::Migration
  def up
    change_column :users, :name, :string, {:default => "", :null => false}
  end

  def down
    change_column :users, :name, :string, {:null => true}
  end
end

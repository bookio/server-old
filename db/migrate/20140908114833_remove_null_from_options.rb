class RemoveNullFromOptions < ActiveRecord::Migration
  def up
    change_column :options, :name, :string, {:default => "", :null => false}
    change_column :options, :description, :text, {:default => "", :null => false}
  
  end

  def down
  end
end

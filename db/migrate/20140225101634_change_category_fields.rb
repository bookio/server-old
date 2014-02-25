class ChangeCategoryFields < ActiveRecord::Migration
  def up
      remove_column :categories, :available
	  add_column :categories, :available, :integer, {:default => 1, :null => false}  
	  add_column :categories, :limit_availability, :integer, {:default => 0, :null => false}
	  add_column :categories, :limit_from, :datetime
	  add_column :categories, :limit_to, :datetime
	  
  end

  def down
  end
end

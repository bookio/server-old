class ModifyCategoriesAgain < ActiveRecord::Migration
  def up
	  remove_column :categories, :limit_from
	  remove_column :categories, :limit_to
	  add_column :categories, :limit_from, :time
	  add_column :categories, :limit_to, :time
  end

  def down
  end
end

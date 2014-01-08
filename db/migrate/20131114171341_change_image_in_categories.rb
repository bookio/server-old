class ChangeImageInCategories < ActiveRecord::Migration
  def up
	  change_column :categories, :image, :text, {:default => "", :null => false}
  end

  def down
  end
end

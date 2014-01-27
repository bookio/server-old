class ChangeDescriptionInCategories < ActiveRecord::Migration
  def up
	  change_column :categories, :description, :text, {:default => "", :null => false}
  end

  def down
  end
end

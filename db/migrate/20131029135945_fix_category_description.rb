class FixCategoryDescription < ActiveRecord::Migration
  def change
    change_column :categories, :description, :string, {:default => "", :null => false}
  end
end

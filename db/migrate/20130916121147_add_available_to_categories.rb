class AddAvailableToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :available, :boolean, {:default => true, :null => false}
  end
end

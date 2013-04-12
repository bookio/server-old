class ChangeCategoryInRentals < ActiveRecord::Migration
  def up
    change_column :rentals, :category, :string, {:default => "", :null => false}
  end

  def down
    change_column :rentals, :category, :string, {:null => true}
  end
end

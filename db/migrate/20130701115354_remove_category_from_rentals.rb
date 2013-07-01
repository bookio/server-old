class RemoveCategoryFromRentals < ActiveRecord::Migration
  def up
    remove_column :rentals, :category
  end

  def down
    add_column :rentals, :category, :string
  end
end

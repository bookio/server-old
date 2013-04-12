class AddCategoryToRentals < ActiveRecord::Migration
  def change
    add_column :rentals, :category, :string
  end
end

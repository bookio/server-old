class AddCategoryToRentalsAgain < ActiveRecord::Migration
  def change
    add_column :rentals, :category_id, :integer
  end
end

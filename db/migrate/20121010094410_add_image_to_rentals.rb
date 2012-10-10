class AddImageToRentals < ActiveRecord::Migration
  def change
    add_column :rentals, :image, :string
  end
end

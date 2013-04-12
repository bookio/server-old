class AddDepthToRentals < ActiveRecord::Migration
  def change
    add_column :rentals, :depth, :integer, {:default => 1, :null => false}
  end
end

class ChangeAvailableInRentals < ActiveRecord::Migration
  def up
    remove_column :rentals, :available
    add_column :rentals, :available, :integer, {:default => 1, :null => false}
  end

  def down
  end
end

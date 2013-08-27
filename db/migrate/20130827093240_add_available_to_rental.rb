class AddAvailableToRental < ActiveRecord::Migration
  def change
    add_column :rentals, :available, :boolean, {:default => true, :null => false}
  end
end

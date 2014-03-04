class ModifyRentalsYetAgain < ActiveRecord::Migration
  def up
	  remove_column :rentals, :data
	  add_column :rentals, :data, :binary, {:default => {}, :null => false}
  end

  def down
  end
end

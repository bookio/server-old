class ModifyRentalsAgain < ActiveRecord::Migration
  def up
	  remove_column :rentals, :foo
	  add_column :rentals, :data, :binary
  end

  def down
  end
end

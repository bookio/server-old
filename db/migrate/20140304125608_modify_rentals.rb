class ModifyRentals < ActiveRecord::Migration
  def up
	  remove_column :rentals, :data
	  add_column :rentals, :foo, :binary
  end

  def down
  end
end

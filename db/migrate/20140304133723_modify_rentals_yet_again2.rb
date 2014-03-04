class ModifyRentalsYetAgain2 < ActiveRecord::Migration
  def up
	  remove_column :rentals, :data
	  add_column :rentals, :data, :binary
  end

  def down
  end
end

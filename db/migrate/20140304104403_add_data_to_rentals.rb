class AddDataToRentals < ActiveRecord::Migration
  def change
    add_column :rentals, :data, :binary
  end
end

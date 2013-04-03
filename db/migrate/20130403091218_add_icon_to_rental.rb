class AddIconToRental < ActiveRecord::Migration
  def change
    add_column :rentals, :icon_id, :integer
  end
end

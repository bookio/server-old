class AddGroupToRentals < ActiveRecord::Migration
  def change
    add_column :rentals, :group_id, :integer
  end
end

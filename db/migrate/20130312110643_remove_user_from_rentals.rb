class RemoveUserFromRentals < ActiveRecord::Migration
  def up
    remove_column :rentals, :user_id
  end

  def down
    add_column :rentals, :user_id, :integer
  end
end

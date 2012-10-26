class AddUserToRentals < ActiveRecord::Migration
  def change
    add_column :rentals, :user_id, :integer
  end
end

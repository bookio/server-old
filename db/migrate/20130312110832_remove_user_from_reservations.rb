class RemoveUserFromReservations < ActiveRecord::Migration
  def up
    remove_column :reservations, :user_id
  end

  def down
    add_column :reservations, :user_id, :integer
  end
end

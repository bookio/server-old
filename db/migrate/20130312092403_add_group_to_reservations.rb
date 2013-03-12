class AddGroupToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :group_id, :integer
  end
end

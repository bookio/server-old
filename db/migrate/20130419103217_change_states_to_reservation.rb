class ChangeStatesToReservation < ActiveRecord::Migration
  def up
    remove_column :reservations, :payed
    remove_column :reservations, :delivered
    remove_column :reservations, :transferred
    remove_column :reservations, :arrived

    add_column :reservations, :payed, :integer, {:default => 0, :null => false}
    add_column :reservations, :delivered, :integer, {:default => 0, :null => false}
    add_column :reservations, :transferred, :integer, {:default => 0, :null => false}
    add_column :reservations, :arrived, :integer, {:default => 0, :null => false}
  end

  def down
  end
end

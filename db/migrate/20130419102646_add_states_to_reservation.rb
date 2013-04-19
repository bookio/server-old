class AddStatesToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :payed, :boolean, {:default => false, :null => false}
    add_column :reservations, :delivered, :boolean, {:default => false, :null => false}
    add_column :reservations, :transferred, :boolean, {:default => false, :null => false}
    add_column :reservations, :arrived, :boolean, {:default => false, :null => false}
  end
end

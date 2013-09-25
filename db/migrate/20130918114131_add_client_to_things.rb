class AddClientToThings < ActiveRecord::Migration
  def change
    add_column :categories, :client_id, :integer
    add_column :settings, :client_id, :integer
    add_column :users, :client_id, :integer
    add_column :rentals, :client_id, :integer
    add_column :customers, :client_id, :integer
    add_column :reservations, :client_id, :integer


  end
end

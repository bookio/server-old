class AddNotesToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :notes, :string, {:default => "", :null => false}
  end
end

class AddEmailToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :email, :string, {:default => "", :null => false}
  end
end

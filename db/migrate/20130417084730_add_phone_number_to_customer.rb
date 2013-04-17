class AddPhoneNumberToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :phone, :string, {:default => "", :null => false}
  end
end

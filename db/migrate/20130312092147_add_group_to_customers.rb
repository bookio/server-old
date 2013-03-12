class AddGroupToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :group_id, :integer
  end
end

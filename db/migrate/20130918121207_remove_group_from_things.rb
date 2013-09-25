class RemoveGroupFromThings < ActiveRecord::Migration
  def up
    remove_column :categories, :group_id
    remove_column :settings, :group_id
    remove_column :users, :group_id
    remove_column :rentals, :group_id
    remove_column :customers, :group_id
    remove_column :reservations, :group_id


  end

  def down
  end
end

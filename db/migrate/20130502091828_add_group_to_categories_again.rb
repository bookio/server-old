class AddGroupToCategoriesAgain < ActiveRecord::Migration
  def change
    add_column :categories, :group_id, :integer
  end
end

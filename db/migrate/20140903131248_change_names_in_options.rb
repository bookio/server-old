class ChangeNamesInOptions < ActiveRecord::Migration
  def up
	  rename_column :options, :title, :name
  end

  def down
  end
end

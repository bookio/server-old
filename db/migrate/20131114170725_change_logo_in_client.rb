class ChangeLogoInClient < ActiveRecord::Migration
  def up
	  change_column :clients, :logo, :text, {:default => "", :null => false}
  end

  def down
  end
end

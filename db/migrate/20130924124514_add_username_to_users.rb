class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, {:default => "", :null => false}
    add_column :users, :guest, :integer, {:default => 0, :null => false}

  end
end

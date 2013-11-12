class ModifyPasswordInUsers < ActiveRecord::Migration
  def change
    change_column :users, :email, :string, {:default => "", :null => false}
  end

end

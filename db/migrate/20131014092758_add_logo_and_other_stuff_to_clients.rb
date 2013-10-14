class AddLogoAndOtherStuffToClients < ActiveRecord::Migration
  def change
    add_column :clients, :logo, :string, {:default => "", :null => false}
    add_column :clients, :email, :string, {:default => "", :null => false}
    add_column :clients, :twitter, :string, {:default => "", :null => false}
    add_column :clients, :facebook, :string, {:default => "", :null => false}
    add_column :clients, :phone, :string, {:default => "", :null => false}
    add_column :clients, :address, :string, {:default => "", :null => false}
    add_column :clients, :www, :string, {:default => "", :null => false}
  end
end

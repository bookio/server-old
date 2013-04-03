class RemoveImageFromRental < ActiveRecord::Migration
  def up
    remove_column :rentals, :image
  end

  def down
    add_column :rentals, :image, :string
  end
end

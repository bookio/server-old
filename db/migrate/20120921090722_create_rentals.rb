class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
      t.text :name
      t.text :description

      t.timestamps
    end
  end
end

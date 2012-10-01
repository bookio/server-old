class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :rental
      t.references :customer
      t.references :user
      t.datetime :begin_at
      t.datetime :end_at
      t.integer :state

      t.timestamps
    end
  end
end

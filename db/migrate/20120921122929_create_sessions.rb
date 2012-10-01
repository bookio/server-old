class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :user
      t.string :sid

      t.timestamps
    end
    add_index :sessions, :user_id
    add_index :sessions, :sid
  end
end

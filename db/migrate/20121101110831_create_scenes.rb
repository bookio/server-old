class CreateScenes < ActiveRecord::Migration
  def change
    create_table :scenes do |t|
      t.string :name
      t.binary :content
      t.references :user

      t.timestamps
    end
    add_index :scenes, :user_id
  end
end

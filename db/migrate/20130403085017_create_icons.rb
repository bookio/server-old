class CreateIcons < ActiveRecord::Migration
  def change
    create_table :icons do |t|
      t.string :name
      t.string :tags
      t.string :image

      t.timestamps
    end
  end
end

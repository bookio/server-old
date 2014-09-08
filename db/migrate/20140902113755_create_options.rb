class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end

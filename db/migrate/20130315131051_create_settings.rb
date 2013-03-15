class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.references :group
      t.string :section
      t.string :name
      t.binary :value

      t.timestamps
    end
  end
end

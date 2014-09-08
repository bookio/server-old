class AddStuffToOptions < ActiveRecord::Migration
  def change
	  add_column :options, :rental_id, :integer
  end
end

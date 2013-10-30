class Category < ActiveRecord::Base
  attr_accessible :description, :name, :image, :available
  
  has_many :rentals
  
  belongs_to :client  
  after_destroy :cleanup
  
  
  def cleanup
  	 Rental.where(:category_id => self.id).update_all(:category_id => nil)
  end
  
   
end

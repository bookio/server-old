class Option < ActiveRecord::Base
  attr_accessible :description, :name, :rental_id
  
  validates :rental_id, :presence => true


  belongs_to :rental  
  
  
end

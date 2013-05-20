class Icon < ActiveRecord::Base
  attr_accessible :image, :name, :tags, :folder
  
  has_many :rentals, :dependent => :destroy
  validates_associated :rentals
    
end

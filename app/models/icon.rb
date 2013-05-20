class Icon < ActiveRecord::Base
  attr_accessible :image, :name, :tags, :type
  
  has_many :rentals, :dependent => :destroy
  validates_associated :rentals
    
end

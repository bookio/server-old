class Category < ActiveRecord::Base
  attr_accessible :description, :name
  
  has_many :rentals, :dependent => :destroy
  validates_associated :rentals
  
  belongs_to :group  
end

class Rental < ActiveRecord::Base
  attr_accessible :description, :name, :image
  has_many :reservations, :dependent => :destroy
  validates_associated :reservations

end

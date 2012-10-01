class Rental < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :reservations, :dependent => :destroy
  validates_associated :reservations

end

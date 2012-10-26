class Customer < ActiveRecord::Base
  attr_accessible :name
  has_many :reservations, :dependent => :destroy
  validates_associated :reservations
  
  belongs_to :user
  
end

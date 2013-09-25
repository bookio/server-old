class Customer < ActiveRecord::Base
  attr_accessible :name, :phone, :email, :notes
  
  has_many :reservations, :dependent => :destroy
  validates_associated :reservations
  
  belongs_to :client
  
end

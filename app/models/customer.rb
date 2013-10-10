class Customer < ActiveRecord::Base
  attr_accessible :name, :phone, :email, :notes
  
  has_many :reservations, :dependent => :destroy
  validates_associated :reservations

  validates_uniqueness_of :email, :allow_blank => true
  
  belongs_to :client
  
end

class Rental < ActiveRecord::Base
  attr_accessible :description, :name, :icon_id, :category_id, :depth, :available, :client_id
  
  validates :client_id, :presence => true

  has_many :reservations, :dependent => :destroy
  validates_associated :reservations

  belongs_to :client
  belongs_to :icon
  belongs_to :category

 
end

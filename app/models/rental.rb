class Rental < ActiveRecord::Base
  attr_accessible :description, :name, :icon_id, :category_id, :depth, :available, :client_id, :data
  
  validates :client_id, :presence => true
  serialize :data

  has_many :reservations, :dependent => :destroy

  belongs_to :client
  belongs_to :icon
  belongs_to :category


end

class Rental < ActiveRecord::Base
  attr_accessible :description, :name, :icon_id, :category_id, :depth

  validates :group_id, :presence => true

  has_many :reservations, :dependent => :destroy
  validates_associated :reservations

  belongs_to :group
  belongs_to :icon
  belongs_to :category

  #def url 
  #	"rentals/" + self.id.to_s
  #end

  #def as_json(options={})
  #  super(:methods => [:url])
  #end

 
end

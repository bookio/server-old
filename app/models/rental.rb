class Rental < ActiveRecord::Base
  attr_accessible :description, :name

  validates :icon_id, :group_id, :presence => true

  has_many :reservations, :dependent => :destroy
  validates_associated :reservations

  belongs_to :group
  belongs_to :icon

  def url 
  	"rentals/" + self.id.to_s
  end

  def as_json(options={})
    super(:methods => [:url])
  end

 
end

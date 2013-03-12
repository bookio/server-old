class Rental < ActiveRecord::Base
  attr_accessible :description, :name, :image
  has_many :reservations, :dependent => :destroy
  validates_associated :reservations

  belongs_to :group

  def url 
  	"rentals/" + self.id.to_s
  end

  def as_json(options={})
#    super(:include => { :user => { :only => :email }}, :methods => [:foo, :bar])
    super(:methods => [:url])
  end

 
end

class Rental < ActiveRecord::Base
  attr_accessible :description, :name, :icon_id, :category_id, :depth, :available, :client_id
  
  validates :client_id, :presence => true

  has_many :reservations, :dependent => :destroy
  #validates_associated :reservations

  belongs_to :client
  belongs_to :icon
  belongs_to :category


=begin
  def self.available(begin_at, end_at)
      
      # find all reservations that occupies the specified period
      reservations = client.reservations.overlap(begin_at, end_at)

      unavailable = []

	  reservations.each do |reservation|
        unavailable.push(reservation.rental_id)
	  end       

	  rentals = client.rentals
	  rentals = rentals.where('available <> 0')
	  rentals = rentals.where('id not in (?)', unavailable)

	  rentals
  end
=end

end

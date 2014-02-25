class Category < ActiveRecord::Base
  attr_accessible :description, :name, :image, :available, :limit_availability, :limit_from, :limit_to
  
  has_many :rentals
  
  belongs_to :client  
  after_destroy :cleanup

  validate :validate_dates

  
  def validate_dates
    if limit_availability
	    if limit_from == nil or limit_from.blank?
	        errors.add(:error, "'limit_from' must be specified")
	    elsif limit_to == nil or limit_to.blank?
	        errors.add(:error, "'limit_to' must be specified")
	    elsif limit_from >= limit_to
	       errors.add(:error, "limit_from must be before limit_to")
	    end
    end
  end
  
  def cleanup
  	 Rental.where(:category_id => self.id).update_all(:category_id => nil)
  end
  
   
end

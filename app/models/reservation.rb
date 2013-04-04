class Reservation < ActiveRecord::Base
  attr_accessible :customer, :end_at, :rental, :begin_at, :state, :group
  
  validates :customer_id, :rental_id, :group_id, :presence => true

  validate :validate_dates, :validate_state


  scope :last_week, lambda { where("created_at > ?", Time.zone.now -  7*(60 * 60 * 24) ) }

  def validate_dates
    if begin_at == nil or begin_at.blank?
      errors.add(:begin_at, "must be specified")
    elsif end_at == nil or end_at.blank?
        errors.add(:end_at, "must be specified")
    elsif begin_at >= end_at
       errors.add(:begin_at, " must be before end_at")
    end
  end
  
  def validate_state
    if state == nil
      errors.add(:state, "must be specified")
    end
  end
  
  def kalle(param)
    param
  end
  
  def foo
    "Foo"
  end
  


  def customer_name
  	self.customer.name;
  end

  def rental_name
  	self.rental.name
  end
 
  belongs_to :rental
  belongs_to :customer
  belongs_to :group
end

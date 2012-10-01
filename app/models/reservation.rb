class Reservation < ActiveRecord::Base
  attr_accessible :customer, :end_at, :rental, :start_at, :state, :user
  
  validates :customer_id, :user_id, :rental_id, :presence => true

  validate :validate_dates, :validate_state

  def validate_dates
    if start_at == nil or start_at.blank?
      errors.add(:start_at, "must be specified")
    elsif end_at == nil or end_at.blank?
        errors.add(:end_at, "must be specified")
    elsif start_at >= end_at
       errors.add(:start_at, " must be before end_at")
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
  
  def user_email
  	self.user.email;
  end

  def customer_name
  	self.customer.name;
  end

  def rental_name
  	self.rental.name
  end
  
  def as_json(options={})
#    super(:include => { :user => { :only => :email }}, :methods => [:foo, :bar])
    super(:methods => [:customer_name, :user_email, :rental_name])
  end

 
  belongs_to :rental
  belongs_to :customer
  belongs_to :user
end

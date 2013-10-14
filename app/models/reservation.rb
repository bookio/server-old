# encoding: utf-8

class Reservation < ActiveRecord::Base
  attr_accessible :customer, :end_at, :rental, :begin_at, :state, :client_id, :payed, :delivered, :transferred, :arrived, :price, :rental_id, :customer_id
  
 # validates :customer_id, :rental_id, :client_id, :presence => true
 # validate :validate_dates, :validate_state, :validate_not_overlap

 # scope :overlaps, ->(begin_at, end_at) do
 #   where("(TIMESTAMP :begin_at, TIMESTAMP :end_at) OVERLAPS (begin_at, end_at)", {:begin_at => begin_at, :end_at => end_at})
 # end

 # scope :not_overlaps, ->(begin_at, end_at) do
 #   where("NOT((TIMESTAMP :begin_at, TIMESTAMP :end_at) OVERLAPS (begin_at, end_at))", {:begin_at => begin_at, :end_at => end_at})
 # end

  
  #def validate_not_overlap
  #  if client.reservations.where("rental_id = ?", rental_id).where('id != ?', id || -1).overlaps(begin_at, end_at).exists?
  #    errors.add(:error, 'Date range overlaps') 
  #  end
  #end


  
  def validate_dates
    if begin_at == nil or begin_at.blank?
        errors.add(:error, "'begin_at' must be specified")
    elsif end_at == nil or end_at.blank?
        errors.add(:error, "'end_at' must be specified")
    elsif begin_at >= end_at
       errors.add(:error, "begin_at must be before end_at")
    end
  end
  
  def validate_state
  end

 
  belongs_to :rental
  belongs_to :customer
  belongs_to :client
end

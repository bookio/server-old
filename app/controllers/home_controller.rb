#require 'active_support'

class HomeController < ApplicationController
  
  def index
    begin
	    reservations = Reservation.joins(:user, :rental).select(['rentals.name', 'rentals.image', 'reservations.id', 'users.email', 'reservations.begin_at', 'reservations.end_at'])
	    render :json => reservations
	    
    rescue Exception => exception
      error exception.message, :not_found
    end
    
  end
end

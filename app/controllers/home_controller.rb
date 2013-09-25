#require 'active_support'

class HomeController < ApplicationController
  
  def foo
    begin
	    #reservations = Reservation.joins(:user, :rental).select(['rentals.name', 'rentals.image', 'reservations.id', 'user.email', 'reservations.begin_at', 'reservations.end_at'])
	    render :json => User.all
	    
    rescue Exception => exception
      error exception.message, :not_found
    end
    
  end
  

  
end

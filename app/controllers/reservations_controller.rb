class ReservationsController < ApplicationController
  
  def index
    json =  render :json => Reservation.all
#    render :json => Reservation.all.to_json(:methods => :kalle)
  end

  def list
    begin
	    reservations = Reservation.joins(:user, :rental).select(['rentals.name', 'rentals.image', 'reservations.id', 'users.email', 'reservations.state', 'reservations.begin_at', 'reservations.end_at'])
	    render :json => reservations
	    
    rescue Exception => exception
      error exception.message, :not_found
    end
  end  

  def show
    begin
      reservation = Reservation.find(params[:id])
      
      render :json => reservation
    
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def create
    begin
      user = authenticate
      
      @reservation = Reservation.new(params[:reservation])
      @reservation.customer = Customer.find(params[:customer_id])
      @reservation.user = user
      @reservation.rental = Rental.find(params[:rental_id])
      
      if @reservation.save
        render :json => @reservation, :status => :created, :location => @reservation
      else
        render :json => @reservation.errors, :status => :unprocessable_entity
        puts @reservation.errors
      end
    rescue Exception => exception
      puts exception.message
      error exception.message, :not_found
    end
  end
  
  def update
	begin
		@reservation = Reservation.find(params[:id])
	
	    if @reservation.update_attributes(params[:rental])
			render :json => @reservation
	    else
	        render :json => @reservation.errors, :status => :unprocessable_entity
	    end
	    
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def destroy
    begin
      @customer = Reservation.find(params[:id])
      @customer.destroy
      head :no_content
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
end

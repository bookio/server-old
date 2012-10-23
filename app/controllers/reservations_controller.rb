class ReservationsController < ApplicationController
  
  def index
    begin
      current_session
      json =  render :json => Reservation.all
    rescue Exception => exception
    	error exception.message, :not_found
    end
  end

  def list
    begin
      current_session
      reservations = Reservation.joins(:user, :rental, :customer).select(['rentals.name', 
	    	'rentals.image', 'rentals.id AS rental_id', 
	    	'reservations.id AS reservation_id', 
	    	'customers.id AS customer_id',
	    	'users.email', 'reservations.state', 'reservations.begin_at', 'reservations.end_at'])
      render :json => reservations
	    
    rescue Exception => exception
      error exception.message, :not_found
    end
  end  

  def show
    begin
      current_session
      
      reservation = Reservation.find(params[:id])
      
      render :json => reservation
    
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def create
    begin
      user = current_session.user
      
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
      current_session
      @reservation = Reservation.find(params[:id])
	
      if @reservation.update_attributes(params[:reservation])
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
      current_session

      @customer = Reservation.find(params[:id])
      @customer.destroy
      head :no_content

    rescue Exception => exception
      error exception.message, :not_found
    end
  end
end

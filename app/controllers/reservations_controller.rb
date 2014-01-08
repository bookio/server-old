class ReservationsController < ApplicationController
  
  def index
    begin
      session = current_session
      json =  render :json => session.user.client.reservations.all
    rescue Exception => exception
    	error exception.message, :not_found
    end
  end

  def bookings
    begin
      session = current_session
      reservations = session.user.client.reservations.all

      json = []
      customers = {}
      rentals = {}
      
      reservations.each { |reservation|
        rentals[reservation.rental_id] = [] unless rentals.has_key? reservation.rental_id
        reservations_for_rental = rentals[reservation.rental_id]
        reservations_for_rental.push(reservation)

        customers[reservation.customer_id] = reservation.customer
      }
	  
	    json = {:customers => customers, 'JJJ' => rentals}
      
      render :json => json
    rescue Exception => exception
    	error exception.message, :not_found
    end
  end


  def foo
    begin
      session = current_session
	    reservations = session.user.client.reservations
	  
      result = {}

  	  reservations.each { |reservation|
        result[reservation.id] = reservation;
      }

      render :json => result
	    
    rescue Exception => exception
      error exception.message, :not_found
    end
  end  

  def show
    begin
      session = current_session
      reservation = session.user.client.reservations.find(params[:id])
      
      render :json => reservation
    
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def create
    begin
      session = current_session
      
      reservation = session.user.client.reservations.new(params[:reservation])
      
      if reservation.save
        render :json => reservation, :status => :created, :location => reservation
      else
        render :json => reservation.errors, :status => :unprocessable_entity
      end
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def update
	begin
      session = current_session
      reservation = session.user.client.reservations.find(params[:id])
	
      if reservation.update_attributes(params[:reservation])
		render :json => reservation
      else
        render :json => reservation.errors, :status => :unprocessable_entity
      end
	    
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def destroy
    begin
      session = current_session

      customer = session.user.client.reservations.find(params[:id])
      customer.destroy
      head :no_content

    rescue Exception => exception
      error exception.message, :not_found
    end
  end
end

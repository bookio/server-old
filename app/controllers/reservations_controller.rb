class ReservationsController < ApplicationController
  
  def index
    begin
      session = current_session
      json =  render :json => session.user.group.reservations.all
    rescue Exception => exception
    	error exception.message, :not_found
    end
  end

  def bookings
    begin
      session = current_session
      reservations = session.user.group.reservations.all

      json = []
      customers = {}
      rentals = {}
      
	  reservations.each do |reservation|
	    if !rentals.has_key?(reservation.rental_id)
          rentals[reservation.rental_id] = []	  	
		end
		reservations_for_rental = rentals[reservation.rental_id]
		reservations_for_rental.push(reservation)
		
		customers[reservation.customer_id] = reservation.customer
	  end
	  
	  json = {:customers => customers, "JJJ" => rentals}
      
      render :json => json
    rescue Exception => exception
    	error exception.message, :not_found
    end
  end


  def foo
    begin
    
      session = current_session

	  reservations = session.user.group.reservations
	  
      result = {}
	  reservations.each do |reservation|
		result[reservation.id] = reservation;	  	
	  end
      #result[:customers] =  session.user.group.customers
      #result[:rentals] =  session.user.group.rentals
      #result[:reservations] =  session.user.group.reservations
      
      #reservations = result #{:customers => session.user.group.customers}
      #session.user.group.reservation.joins(:group, :rental, :customer).select(['rentals.name', 
	  #  	'rentals.image', 'rentals.id AS rental_id', 
	  #  	'reservations.id AS reservation_id', 
	  #  	'customers.id AS customer_id',
	  #  	'reservations.state', 'reservations.begin_at', 'reservations.end_at'])
      render :json => result
	    
    rescue Exception => exception
      error exception.message, :not_found
    end
  end  

  def show
    begin
      session = current_session
      reservation = session.user.group.reservations.find(params[:id])
      
      render :json => reservation
    
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def create
    begin
      session = current_session
      
      reservation = session.user.group.reservations.new(params[:reservation])
      reservation.customer = session.user.group.customers.find(params[:customer_id])
      reservation.rental = session.user.group.rentals.find(params[:rental_id])
      
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
      reservation = session.user.group.reservations.find(params[:id])
	
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

      customer = session.user.group.reservations.find(params[:id])
      customer.destroy
      head :no_content

    rescue Exception => exception
      error exception.message, :not_found
    end
  end
end

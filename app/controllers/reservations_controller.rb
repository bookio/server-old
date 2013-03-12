class ReservationsController < ApplicationController
  
  def index
    begin
      session = current_session
      json =  render :json => session.user.group.reservations.all
    rescue Exception => exception
    	error exception.message, :not_found
    end
  end


  def list
    begin
    
      session = current_session
      reservations = session.user.group.reservation.joins(:group, :rental, :customer).select(['rentals.name', 
	    	'rentals.image', 'rentals.id AS rental_id', 
	    	'reservations.id AS reservation_id', 
	    	'customers.id AS customer_id',
	    	'reservations.state', 'reservations.begin_at', 'reservations.end_at'])
      render :json => reservations
	    
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

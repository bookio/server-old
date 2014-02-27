class RentalsController < ApplicationController


  def index
    begin
      session = current_session
      output session.user.client.rentals.all
    rescue Exception => exception
      error exception.message, :not_found
    end

  end

  def query
    begin
      session = current_session
      begin_at = DateTime.parse(params[:begin_at])
      end_at = DateTime.parse(params[:end_at])
      category_id = params[:category_id]
      
      reservations = session.user.client.reservations.overlaps(begin_at, end_at).select(:rental_id)

      unavailable = []

	  reservations.each do |reservation|
        unavailable.push(reservation.rental_id)
	  end       

	  rentals = session.user.client.rentals
	  rentals = rentals.where('available <> 0')
	  
	  if unavailable.count > 0
    	  rentals = rentals.where("id not in (?)", unavailable)
	  end
	  
	  if category_id != nil
    	  rentals = rentals.where("category_id = ?", category_id)
	  end

      output rentals.all
      
    rescue Exception => exception
    	error exception.message, :not_found
    end
    
  end
  
  
  # Returns an array containing all existing categories
  
  def show
  	begin
      output current_session.user.client.rentals.find(params[:id])
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def create
    begin
      session = current_session
      rental = session.user.client.rentals.new(params[:rental])
      
      if params[:icon_id]
          rental.icon = Icon.find(params[:icon_id])
      else
          rental.icon = nil
      end
      
      if params[:category_id]
          rental.category = Category.find(params[:category_id])
      else
          rental.category = nil
      end
      
      if rental.save
        output rental
      else
        render :json => rental.errors, :status => :unprocessable_entity
      end
    rescue Exception => exception
      error exception.message, :not_found
    end

  end
  
  def update
	begin
      session = current_session
      rental = session.user.client.rentals.find(params[:id])
	
      if rental.update_attributes(params[:rental])
  		output rental
      else
        render :json => rental.errors, :status => :unprocessable_entity
      end
	    
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def destroy
    begin
      session = current_session

      rental = session.user.client.rentals.find(params[:id])
      rental.destroy
      
      head :no_content
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

end

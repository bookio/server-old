class RentalsController < ApplicationController


  def index
    begin
      session = current_session
      
      rentals = session.user.group.rentals.all
      render :json => rentals
    rescue Exception => exception
      error exception.message, :not_found
    end

  end


  # Returns an array containing all existing categories
  def categories
    begin
        
      session = current_session
      
      results = session.user.group.rentals.select("DISTINCT(rentals.category), rentals.category").where("rentals.category IS NOT NULL AND LENGTH(rentals.category) > 0")

      categories = []
      
	  results.each do |result|
		categories.push(result["category"])	  	
	  end

      render :json => categories
    rescue Exception => exception
      error exception.message, :not_found
    end

  end
  
  def show
  	begin
      session = current_session

      rental = session.user.group.rentals.find(params[:id])
      render :json => rental
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def create
    begin
      session = current_session
      rental = session.user.group.rentals.new(params[:rental])
      rental.icon = Icon.find(params[:icon_id])

      if rental.save
        render :json => rental, :status => :created, :location => rental
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
      rental = session.user.group.rentals.find(params[:id])
	
      if rental.update_attributes(params[:rental])
  		render :json => rental
      else
        render :json => rental, :status => :unprocessable_entity
      end
	    
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def destroy
    begin
      session = current_session

      rental = session.user.group.rentals.find(params[:id])
      rental.destroy
      
      head :no_content
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

end

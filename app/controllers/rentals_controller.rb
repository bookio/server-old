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
        render :json => rental.errors, :status => :unprocessable_entity
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

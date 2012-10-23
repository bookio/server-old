class RentalsController < ApplicationController


  def index
    begin
      session = current_session
      
      @rentals = Rental.all
      render :json => @rentals
    rescue Exception => exception
      error exception.message, :not_found
    end

  end
  
  def show
  	begin
      session = current_session

      @rental = Rental.find(params[:id])
      render :json => @rental
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def create
    begin
      session = current_session

      @rental = Rental.new(params[:rental])

      if @rental.save
        render :json => @rental, :status => :created, :location => @rental
      else
        render :json => @rental.errors, :status => :unprocessable_entity
      end
    rescue Exception => exception
      error exception.message, :not_found
    end

  end
  
  def update
	begin
      session = current_session
      @rental = Rental.find(params[:id])
	
      if @rental.update_attributes(params[:rental])
  		render :json => @rental
      else
        render :json => @rental, :status => :unprocessable_entity
      end
	    
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def destroy
    begin
      session = current_session

      @rental = Rental.find(params[:id])
      @rental.destroy
      head :no_content
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

end

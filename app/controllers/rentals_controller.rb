class RentalsController < ApplicationController


  def index
    @rentals = Rental.all
    render :json => @rentals
  end
  
  def show
  	begin
      @rental = Rental.find(params[:id])
      render :json => @rental
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def create
    @rental = Rental.new(params[:rental])

    if @rental.save
      render :json => @rental, :status => :created, :location => @rental
    else
      render :json => @rental.errors, :status => :unprocessable_entity
    end
  end
  
  def update
	begin
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
      @rental = Rental.find(params[:id])
      @rental.destroy
      head :no_content
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

end

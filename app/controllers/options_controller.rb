class OptionsController < ApplicationController

  
  def get
  	begin
      rental = current_session.user.client.rentals.find(params[:rental_id])
      option = Option.find(params[:id])
	  output option
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
    
  def fetch
  	begin
      rental = current_session.user.client.rentals.find(params[:rental_id])
      output rental.options.all()

    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def create
    begin
      session = current_session
      rental = session.user.client.rentals.find(params[:rental_id])
	  option = Option.new(params[:option])

	  option.rental_id = params[:rental_id]
	  
      if option.save
        output option
      else
	    render :json => option.errors, :status => :unprocessable_entity
      end

    rescue Exception => exception
      error exception.message, :not_found
    end

  end
  
  def update
	begin
      rental = current_session.user.client.rentals.find(params[:rental_id])
      option = Option.find(params[:id])

      if option.update_attributes(params[:option])
  		output option
      else
        render :json => rental.option, :status => :unprocessable_entity
      end
      
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def destroy
    begin
    
      rental = current_session.user.client.rentals.find(params[:rental_id])
      option = Option.find(params[:id])
      option.destroy
          
    
      head :no_content
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

end

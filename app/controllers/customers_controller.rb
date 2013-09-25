class CustomersController < ApplicationController
  
  def index
    begin
      session = current_session
      customers = session.user.client.customers
      render :json => customers
    
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def show
    begin
      session = current_session

      customer = session.user.client.customers.find(params[:id])
      render :json => customer
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  

  def search
    begin
      session = current_session
      
      customers = session.user.client.customers.where("name ILIKE ? OR email ILIKE ? OR phone ILIKE ?", "%#{params[:search_text]}%", "%#{params[:search_text]}%", "%#{params[:search_text]}%")
      render :json => customers

    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def create
    begin
      session = current_session
      
      customer = session.user.client.customers.new(params[:customer])
      
      if customer.save
        render :json => customer, :status => :created
      else
        render :json => customer.errors, :status => :unprocessable_entity
      end
    rescue Exception => exception
      error exception.message, :not_found
    end
    
  end
  
  def update
	begin
      session = current_session
      customer = session.user.client.customers.find(params[:id])
	
      if customer.update_attributes(params[:customer])
		render :json => customer
      else
        render :json => customer.errors, :status => :unprocessable_entity
      end
	    
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def destroy
    begin
      current_session
      
      @customer = Customer.find(params[:id])
      @customer.destroy
      head :no_content

    rescue Exception => exception
      error exception.message, :not_found
    end
  end
end

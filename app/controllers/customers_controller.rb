class CustomersController < ApplicationController
  
  def index
    begin
      session = current_session
      customers = session.user.group.customers
      render :json => customers
    
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def show
    begin
      session = current_session

      customer = session.user.group.customers.find(params[:id])
      render :json => customer
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  

  def search
    begin
      session = current_session
      
      customers = session.user.group.customers.where("lower(name) LIKE ?", "%#{params[:search_text].downcase}%")
      render :json => customers

    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def create
    begin
      session = current_session
      
      customer = session.user.group.customers.new(params[:customer])
      
      if customer.save
        render :json => customer, :status => :created, :location => @customer
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
      customer = session.user.group.customers.find(params[:id])
	
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

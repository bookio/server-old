class CustomersController < ApplicationController
  
  def index
    begin
      current_session
      
      @customers = Customer.all
      render :json => @customers
    
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def show
    begin
      current_session
      
      @customer = Customer.find(params[:id])
      render :json => @customer
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def search
    begin
      current_session
      
      customers = Customer.where("lower(name) LIKE ?", "%#{params[:search_text].downcase}%")
      render :json => customers

    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def create
    begin
      current_session
      
      @customer = Customer.new(params[:customer])

      if @customer.save
        render :json => @customer, :status => :created, :location => @customer
      else
        render :json => @customer.errors, :status => :unprocessable_entity
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

class CustomersController < ApplicationController
  
  def index
    @customers = Customer.all
    render :json => @customers
  end
  
  def show
  begin
      @customer = Customer.find(params[:id])
      render :json => @customer
    rescue ActiveRecord::RecordNotFound
      error "Customer with ID #{params[:id]} not found.", :not_found
    end
  end

  def search
  begin
      customers = Customer.where("lower(name) LIKE ?", "%#{params[:search_text].downcase}%")
      render :json => customers
    rescue ActiveRecord::RecordNotFound
      error "Customer matching #{params[:search_text]} not found.", :not_found
    end
  end

  def create
    @customer = Customer.new(params[:customer])

    if @customer.save
      render :json => @customer, :status => :created, :location => @customer
    else
      render :json => @customer.errors, :status => :unprocessable_entity
    end
  end
  
  def destroy
    begin
      @customer = Customer.find(params[:id])
      @customer.destroy
      head :no_content
    rescue ActiveRecord::RecordNotFound
      error "Customer with ID #{params[:id]} not found.", :not_found
    end
  end
end

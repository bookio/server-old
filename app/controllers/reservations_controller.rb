class ReservationsController < ApplicationController
  
  def index
    json = 
    render :json => Reservation.all
#    render :json => Reservation.all.to_json(:methods => :kalle)
  end
  

  def show
  begin
      reservation = Reservation.find(params[:id])
      
      render :json => reservation
    rescue ActiveRecord::RecordNotFound
      error "Reservation with ID #{params[:id]} not found.", :not_found
    end
  end

  def create
      puts params.to_s

      user = authenticate
      
      @reservation = Reservation.new(params[:reservation])
      @reservation.customer = Customer.find(params[:customer_id])
      @reservation.user = user
      @reservation.rental = Rental.find(params[:rental_id])
      
      if @reservation.save
        render :json => @reservation, :status => :created, :location => @reservation
      else
        render :json => @reservation.errors, :status => :unprocessable_entity
      end
  end

  def destroy
    begin
      @customer = Reservation.find(params[:id])
      @customer.destroy
      head :no_content
    rescue ActiveRecord::RecordNotFound
      error "Reservation with ID #{params[:id]} not found.", :not_found
    end
  end
end

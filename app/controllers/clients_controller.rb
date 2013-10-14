class ClientsController < ApplicationController

    def self_get
        begin
            session = current_session
            render :json => session.user.client
        rescue Exception => exception
            error exception.message, :not_found
        end
    end

    def self_update
        begin
            session = current_session
            client = session.user.client

            if client.update_attributes(params[:client])
        		render :json => client
            else
                render :json => client, :status => :unprocessable_entity
            end
                
        rescue Exception => exception
            error exception.message, :not_found
        end
    end



  def index
    begin
      clients = Client.all
      render :json => clients
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def show
    begin
      client = Client.find(params[:id])
      render :json => client
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def destroy
    begin
      client = Client.find(params[:id])
      client.destroy
      head :no_content
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def update
	begin
      client = Client.find(params[:id])
	
      if client.update_attributes(params[:client])
  		render :json => client
      else
        render :json => client, :status => :unprocessable_entity
      end
	    
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def create
    begin
      client = Client.new(params[:client])
      if client.save
        render :json => client, :status => :created
      else
        render :json => client.errors, :status => :unprocessable_entity 
      end
    rescue Exception => exception
      error exception.message, :not_found
    end

  end
end

class UsersController < ApplicationController

  def index
    begin
      session = current_session
      users = session.user.client.users.where("guest = 0")
      render :json => users
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def show
    begin
      session = current_session
      user = session.user.client.users.find(params[:id])

      render :json => user
    rescue Exception => exception
      error exception.message, :not_found
    end
  end


  def guest
    begin
      session = current_session
      user = session.user.client.users.find_by_guest(true)

      if user == nil 
        user = session.user.client.users.new
        user.username = rand(36**32).to_s(36)
        user.password = ""
        user.guest = true
        user.save!
      end
      
      render :json => user
    rescue Exception => exception
      error exception.message, :not_found
    end
  end


  def destroy
    begin
      user = User.find(params[:id])
      user.destroy
      head :no_content
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def create
    begin
      session = current_session
      user = session.user.client.users.new(params[:user])

      if user.save
        render :json => user, :status => :created
      else
        render :json => user.errors, :status => :unprocessable_entity 
      end
    rescue Exception => exception
      error exception.message, :not_found
    end

  end
  
  def update
	begin
      session = current_session
      user = session.user.client.users.find(params[:id])
	
      if user.update_attributes(params[:user])
		render :json => user
      else
        render :json => user.errors, :status => :unprocessable_entity
      end
	    
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  
end

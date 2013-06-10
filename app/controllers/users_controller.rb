class UsersController < ApplicationController

  def index
    begin
      @users = User.all
      render :json => @users
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def show
    begin
      session = current_session
      user = session.user.group.users.find(params[:id])

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
      user = session.user.group.users.new(params[:user])

      if user.save
        render :json => user, :status => :created, :location => user
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
      user = session.user.group.users.find(params[:id])
	
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

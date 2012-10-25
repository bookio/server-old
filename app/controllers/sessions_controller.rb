class SessionsController < ApplicationController
  def new
  end

  def index
    begin
      @sessions = Session.all
      render :json => @sessions
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def show
    begin
      @session = Session.find(params[:id])
      render :json => @session
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def verify
    begin
      session = current_session
      render :json => {:sid => session.sid}
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def login
    begin
      user = authenticate

      session = Session.find_by_user_id(user.id)
        
      if session != nil
        session.destroy
      end
      
      session = Session.new 
      session.user = user 
      session.save
      
      render :json => {:sid => session.sid}


    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  
  def logout
    begin
      session = current_session
    
      session.destroy
      head :no_content
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def destroy
    begin
      @session = Session.find(params[:id])
      @session.destroy
      head :no_content
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
end

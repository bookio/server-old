require 'bcrypt'

class SessionsController < ApplicationController
  def new
  end

  def index
    begin
      sessions = Session.all
      render :json => sessions
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def show
    begin
      session = Session.find(params[:id])
      render :json => session
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def verify
    begin
      session = current_session
      render :json => {:sid => session.sid, :client => session.user.client, :user => session.user}
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def find_user_by_email
    begin
 
      email = params[:email]
      user = User.find_by_email(email)

      if user == nil 
        user = {}
      end
      
      render :json => user
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  # @return [void]
  def signup
    begin
	    user = authenticate(true)
      session = Session.find_by_user_id(user.id)

      if session == nil
          session = Session.new 
          session.user = user 
          session.save
      end
      
      render :json => {:sid => session.sid, :client => session.user.client, :user => session.user}

    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  # @return [void]
  def login
    begin
      creds = credentials
      username = creds[:username]
      password = creds[:password]
      user = User.find_by_username(username)

      if password == nil
	      password = ''
      end
      
      if user == nil
        raise 'Invalid username.'
      end
    
      if user.guest == 0
        raise 'Invalid password' if user.password != password
      end

      session = Session.find_by_user(user)
        
      if session == nil
          session = Session.new 
          session.user = user 
          session.save
      end
      
      render :json => {:sid => session.sid, :client => session.user.client, :user => session.user}

    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  # @return [void]
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
      session = Session.find(params[:id])
      session.destroy
      head :no_content
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
end

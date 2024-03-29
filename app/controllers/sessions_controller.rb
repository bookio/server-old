class SessionsController < ApplicationController
  def new
  end

  def index
    begin
      output Session.all
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def show
    begin
      output Session.find(params[:id])

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
      
      output user
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def signup
    begin
      credentials = credentials()
      
      username = credentials[:username]
      password = credentials[:password]
      
      user = User.find_by_username(username)

      if user == nil
	      ActiveRecord::Base.transaction do        
	        client = Client.new
	        client.name = "Bookio"
	        client.save!
	            
	        user = client.users.new
	        user.name = username
	        user.username = username
	        user.email = username
	        user.password = password   
	        user.save!
	      end
	  end
	  
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
  
  def login
    begin
      credentials = credentials()
      username = credentials[:username]
      password = credentials[:password]
      user = User.find_by_username(username)

      if password == nil
	      password = ""
      end
      
      if user == nil
        raise "Invalid user name."
      end
    
      if user.guest == 0 
        if user.password_hash != nil
	          if user.password_hash != BCrypt::Engine.hash_secret(password, user.password_salt)
	            raise "Invalid password."
	          end
	    else
	    	if password != ''
	            raise "Invalid password."
	    	end
	    end
      end

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

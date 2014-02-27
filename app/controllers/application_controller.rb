class ApplicationController < ActionController::Base
  protect_from_forgery

  
  def error(msg, status)
    render :json => {:error => msg}, :status => status
  end
  
  def base64Decode(str)
    str += '=' * (4 - str.length.modulo(4))
    Base64.decode64(str.tr('-_','+/'))
  end


  def output(array)
	  if params[:hash] != nil 
		  hash = {}
		  hashkey = params[:hash] 
		  
		  array.each do |item|
			key = item[hashkey]
			hash[key] = item;	  	
		  end
	  
		  render :json => hash
	  else
	        render :json => array
	  end
  end


  def current_session
    sid = request.headers["Authorization"]
    
    if sid == nil 
      raise "Must supply a session ID." 
    end
    
    session = Session.find_by_sid(sid)
    
    if session == nil 
      raise "Invalid session ID." 
    end
    
    session
  end
  
  def credentials()
    authorization = request.headers["Authorization"]
    
    if authorization == nil 
      raise "There is no authorization specified in the http header."
    end
    
    authorization = authorization.split(' ')[1]
    
    if (authorization == nil) 
      raise "There is no authorization specified in the http header."
    end
    
    authorization = base64Decode(authorization)
    username = authorization.split(':')[0]
    password = authorization.split(':')[1]
    
    if username == nil
        raise "A user name must be specified."
    end

    if password == nil 
        password = ""
    end
    
    {:username => username, :password => password}
  end
  
  def authenticate(createIfNeeded)
  
    authorization = request.headers["Authorization"]
    
    if authorization == nil 
      raise "There is no authorization specified in the http header."
    end
    
    authorization = authorization.split(' ')[1]
    
    if (authorization == nil) 
      raise "There is no authorization specified in the http header."
    end
    
    authorization = base64Decode(authorization)
    username = authorization.split(':')[0]
    password = authorization.split(':')[1]

#    x = foo()
 #   puts x[:username]
    
    user = nil 
    
    if username == nil
        raise "A user name must be specified."
    end

    if password == nil 
        password = ""
    end
    
    user = User.find_by_username(username)

    if createIfNeeded 
        if user == nil
            ActiveRecord::Base.transaction do        
                client = Client.new
                client.name = "Bookio"
                client.save!
                
                user = client.users.new
                user.username = username
                user.password = password   
                user.save!
            end
        else 
            raise "This user name is currently in use."
        end
    else 
        if user.guest == 0 
            if user == nil || user.password_hash != BCrypt::Engine.hash_secret(password, user.password_salt)
                raise "Invalid user name or password."
            end
        end
    end
    
    user
  end
  
  
  
  
  
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
    
end

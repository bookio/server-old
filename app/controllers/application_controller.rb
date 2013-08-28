class ApplicationController < ActionController::Base
  protect_from_forgery

  
  def error(msg, status)
    render :json => {:error => msg}, :status => status
  end
  
  def base64Decode(str)
    str += '=' * (4 - str.length.modulo(4))
    Base64.decode64(str.tr('-_','+/'))
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
  
  def authenticate(createIfNeeded)
  
    authorization = request.headers["Authorization"]
    
    if authorization == nil 
      raise "There is no authorization specified in the http header."
    end
    
    authorization = authorization.split(' ')[1]
    
    if (authorization == nil) 
      raise "There is no authorization specified in the http header."
    end
    
    emailAndPassword = base64Decode(authorization)
    email = emailAndPassword.split(':')[0]
    password = emailAndPassword.split(':')[1]
    user = nil 
    
    if email == nil
        raise "An e-mail address must be specified."
    end
    
    user = User.find_by_email(email)

    if createIfNeeded 
        if user == nil
            ActiveRecord::Base.transaction do        
                group = Group.new
                group.name = "Bookio"
                group.save!
                
                user = group.users.new
                user.name = email
                user.email = email
                user.password = password   
                user.save!
            end
        else 
            raise "This e-mail address is currently in use."
        end
    else 
        if user == nil || user.password_hash != BCrypt::Engine.hash_secret(password, user.password_salt)
          raise "Invalid e-mail address or password."
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

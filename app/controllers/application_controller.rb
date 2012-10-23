class ApplicationController < ActionController::Base
  protect_from_forgery
  #force_ssl
  


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
  
  
  def authenticate
    authorization = request.headers["Authorization"].split(' ')[1]
    
    if (authorization == nil) 
      raise "Must supply authorization"
    end
    
    emailAndPassword = base64Decode(authorization)
    email = emailAndPassword.split(':')[0]
    password = emailAndPassword.split(':')[1]
    user = nil 
    
    if email == nil || password == nil
      raise "Must supply e-mail and password"
    end
    
    user = User.find_by_email(email)

    if user == nil || user.password_hash != BCrypt::Engine.hash_secret(password, user.password_salt)
      raise "Invalid email or password"
    end
    
    user
  end
  
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
    
end

class ApplicationController < ActionController::Base
  protect_from_forgery
  #force_ssl
  


  def error(msg, status)
    render :json => {:error => msg}, :status => status
  end
  
  def generate_sid
    rand(36**32).to_s(36) 
  end
  
  def current_session
    Session.find_by_sid(request.headers["Authorization"])
  end
  
  def verify_sid
    session = current_session
    
    if session == nil
      error "Invalid session ID", :not_found
    else
      yield
    end
  end
  
  def base64Decode(str)
    str += '=' * (4 - str.length.modulo(4))
    Base64.decode64(str.tr('-_','+/'))
  end
  
  def authenticate
    authorization = request.headers["Authorization"].split(' ')[1]
    
    if (authorization == nil) 
      nil
      return
    end
    
    emailAndPassword = base64Decode(authorization)
    email = emailAndPassword.split(':')[0]
    password = emailAndPassword.split(':')[1]
    
    if email == nil || password == nil
      nil
    else
      user = User.find_by_email(email)

      if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
        user
      else
        nil
      end
    end
  end
  
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
    
end

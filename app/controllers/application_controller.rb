class ApplicationController < ActionController::Base
  protect_from_forgery
  #force_ssl
  
before_filter :cors_preflight_check
after_filter :cors_set_access_control_headers

# For all responses in this controller, return the CORS access control headers.

def cors_set_access_control_headers
  headers['Access-Control-Allow-Origin'] = '*'
  headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
  headers['Access-Control-Max-Age'] = "1728000"
end

# If this is a preflight OPTIONS request, then short-circuit the
# request, return only the necessary headers and return an empty
# text/plain.

def cors_preflight_check
  if request.method == :options
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
    headers['Access-Control-Max-Age'] = '1728000'
    render :text => '', :content_type => 'text/plain'
  end
end
  
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

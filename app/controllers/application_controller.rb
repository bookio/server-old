class ApplicationController < ActionController::Base
  protect_from_forgery

  def error(msg, status)
    render :json => {:error => msg}, :status => status
  end

  def base64decode(str)
    str += '=' * (4 - str.length.modulo(4))
    Base64.decode64(str.tr('-_', '+/'))
  end

  # @return [Session] Active session for the user, raises exception if it fails
  def current_session
    sid = request.headers['Authorization']
    raise 'Must supply a session ID.' if sid.nil?
    session = Session.find_by_sid(sid)
    raise 'Invalid session ID.' if session.nil?

    session
  end

  # @return [Hash] Hash containing username and password from the Authorization header
  def credentials
    #The header is set by the client side and should be "Basic b64(user:pass)"
    authorization = request.headers['Authorization']
    raise 'There is no authorization specified in the http header.' if authorization.nil?

    authorization = authorization.split(' ')[1]
    raise 'There is no authorization specified in the http header.' if authorization.nil?

    authorization = base64decode(authorization)
    username, password = authorization.split(':')

    raise 'A user name must be specified.' if username.nil?
    password ||= ''

    {:username => username, :password => password}
  end

  # @param create_if_needed [bool] Create the user account if not existing
  # @return [User] User object
  def authenticate(create_if_needed = false)
    creds = credentials
    username = creds[:username]
    password = creds[:password]

    raise 'A user name must be specified.' if username.nil?
    password ||= ''

    user = User.find_by_username(username)

    if user.nil?
      if create_if_needed
        ActiveRecord::Base.transaction do
          client = Client.new
          client.name = 'Bookio'
          client.save!

          user = client.users.new
          user.username = username
          user.password = password
          user.save!
        end
      else
        raise 'Invalid username or password'
      end
    elsif user.guest == 0
      raise 'Invalid username or password' if user.password != password
    end

    user
  end


  helper_method :current_user

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  before_filter :set_format

  def set_format
    request.format = 'json'
  end
end

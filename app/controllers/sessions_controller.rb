class SessionsController < ApplicationController
  def new
  end

  def index
    @sessions = Session.all
    render :json => @sessions
  end
  
  def show
  begin
      @session = Session.find(params[:id])
      render :json => @session
    rescue ActiveRecord::RecordNotFound
      error "Session with ID #{params[:id]} not found.", :not_found
    end
  end
  
  def create
    @session = Session.new(params[:session])

    if @session.save
      render :json => @session, :status => :created, :location => @session
    else
      render :json => @session.errors, :status => :unprocessable_entity
    end
  end
  
  def login
    begin
      user = authenticate
      
      if user
        render :json => user
      else
        error "Invalid email or password.", :not_found
      end
    rescue ActiveRecord::RecordNotFound
      error "Authentication failed. ", :not_found
    end
  end

  
  def logout
    session = current_session
    
    if session != nil
      session.destroy
      head :no_content
    else
      error "Invalid session", :not_found
    end
    
  end
  
  def destroy
    begin
      @session = Session.find(params[:id])
      @session.destroy
      head :no_content
    rescue ActiveRecord::RecordNotFound
      error "Session with ID #{params[:id]} not found.", :not_found
    end
  end
end

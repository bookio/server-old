class ScenesController < ApplicationController

  def index
    begin
      session = current_session
      
      scenes = session.user.scenes.all
      render :json => scenes
    rescue Exception => exception
      error exception.message, :not_found
    end

  end
  
  def show
  	begin
      session = current_session

      scene = session.user.scenes.find(params[:id])
      render :json => scene
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def create
    begin
      session = current_session
      scene = session.user.scenes.new(params[:scene])

      if scene.save
        render :json => scene, :status => :created, :location => scene
      else
        render :json => scene.errors, :status => :unprocessable_entity
      end
    rescue Exception => exception
      error exception.message, :not_found
    end

  end
  
  def update
	begin
      session = current_session
      scene = session.user.scenes.find(params[:id])
	
      if scene.update_attributes(params[:scene])
  		render :json => scene
      else
        render :json => scene, :status => :unprocessable_entity
      end
	    
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def destroy
    begin
      session = current_session

      scene = session.user.scenes.find(params[:id])
      scene.destroy
      
      head :no_content
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
end

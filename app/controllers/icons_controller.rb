class IconsController < ApplicationController

  def index
    begin
      icons = Icon.all
      render :json => icons
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def destroy
    begin
      icon = Icon.find(params[:id])
      icon.destroy
      head :no_content
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def all   
	  icons = Icon.all
	  
      result = {}

	  icons.each do |icon|
		result[icon.id] = icon;	  	
	  end

      render :json => result
  
  end
  
  
  def create
    begin
      icon = Icon.new(params[:icon])
      if icon.save
        render :json => icon, :status => :created, :location => icon
      else
        render :json => icon.errors, :status => :unprocessable_entity 
      end
    rescue Exception => exception
      error exception.message, :not_found
    end

  end
  
end

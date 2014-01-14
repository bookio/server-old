class IconsController < ApplicationController

  # Return all icons
  def icons_all
    begin
      icons = Icon.all
      render :json => icons
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  # Return all tags as an array
  def icons_tags
    begin
      icons = Icon.select("DISTINCT tag").where("tag <> ''").order('tag')
      result = []
      
	  icons.each do |icon|
	    result.push(icon.tag)
	  end
      
      render :json => result
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  # Return all icons as a hash
  def icons_hash   
	  icons = Icon.all
	  
      result = {}

	  icons.each do |icon|
		result[icon.id] = icon;	  	
	  end

      render :json => result
  
  end
  
  
  
end

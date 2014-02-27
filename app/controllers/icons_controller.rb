class IconsController < ApplicationController


  
  # Return all icons
  def icons_all
    begin
      output Icon.all      
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
      
      render :json => output(result)
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  
  
end

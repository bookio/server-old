#require 'active_support'

class HomeController < ApplicationController
  
  
  def index
    begin
      raise "error"
    rescue 
      render :json => "Error"
    end
    
  end
end

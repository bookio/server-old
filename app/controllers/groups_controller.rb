class GroupsController < ApplicationController

  def index
    begin
      output Group.all
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def show
    begin
      output Group.find(params[:id])

    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def destroy
    begin
      group = Group.find(params[:id])
      group.destroy
      head :no_content
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def update
	begin
      group = Group.find(params[:id])
	
      if group.update_attributes(params[:group])
  		output group
      else
        render :json => group, :status => :unprocessable_entity
      end
	    
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def create
    begin
      group = Group.new(params[:group])
      if group.save
        output group
      else
        render :json => group.errors, :status => :unprocessable_entity 
      end
    rescue Exception => exception
      error exception.message, :not_found
    end

  end
end

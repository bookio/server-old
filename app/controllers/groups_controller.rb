class GroupsController < ApplicationController

  def index
    begin
      @groups = Group.all
      render :json => @groups
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def show
    begin
      @groups = Group.find(params[:id])
      render :json => @groups
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
  		render :json => group
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
        render :json => group, :status => :created, :location => group
      else
        render :json => group.errors, :status => :unprocessable_entity 
      end
    rescue Exception => exception
      error exception.message, :not_found
    end

  end
end

class CategoriesController < ApplicationController

  def fetch_all
    begin
      session = current_session
      categories = session.user.group.categories
      render :json => categories
    
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def fetch
    begin
      session = current_session

      category = session.user.group.categories.find(params[:id])
      render :json => category
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  
  def create
    begin
      session = current_session
      
      category = session.user.group.categories.new(params[:category])
      
      if category.save
        render :json => category, :status => :created, :location => category
      else
        render :json => category.errors, :status => :unprocessable_entity
      end
    rescue Exception => exception
      error exception.message, :not_found
    end
    
  end
  
  def update
	begin
      session = current_session
      category = session.user.group.categories.find(params[:id])
	
      if category.update_attributes(params[:category])
		render :json => category
      else
        render :json => category.errors, :status => :unprocessable_entity
      end
	    
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def destroy
    begin
      current_session
      
      category = Category.find(params[:id])
      category.destroy
      head :no_content

    rescue Exception => exception
      error exception.message, :not_found
    end
  end

end

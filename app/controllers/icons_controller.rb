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

  def show
    begin
      icon = Icon.find(params[:id])
      render :json => icon
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def get_by_folder
    begin
      icons = Icon.where({:folder => params[:folder]})
      #"type ILIKE ?", "%#{params[:type]}%")
      render :json => icons
    rescue Exception => exception
      error exception.message, :not_found
    end

  end


  def all
    icons = Icon.all
    render :json => icons.index_by(&:id)
  end


  def create
    begin
      icon = Icon.new(params[:icon])
      if icon.save then
        render :json => icon, :status => :created, :location => icon
      else
        render :json => icon.errors, :status => :unprocessable_entity
      end
    rescue Exception => exception
      error exception.message, :not_found
    end

  end

end

class SettingsController < ApplicationController


  def index
    begin
      session = current_session
      
      render :json => session.user.client.settings.all
    rescue Exception => exception
      error exception.message, :not_found
    end

  end
  
  def get
  	begin
      session = current_session
      setting = session.user.client.settings.where('section = ? and name = ?', params[:section], params[:name]).first
      
      if setting == nil 
        render :json => nil 
      else
        render :json => setting.value
      end
      
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  
  def put
  	begin
      session = current_session

      body = request.body.read

      if body.blank?
        session.user.client.settings.where('section = ? and name = ?', params[:section], params[:name]).destroy_all
        head :no_content
      else
        value = ActiveSupport::JSON.decode(body)

        setting = session.user.client.settings.where('section = ? and name = ?', params[:section], params[:name]).first

        if setting.nil?
          setting = session.user.client.settings.new(params[:setting])
          setting.section = params[:section]
          setting.name = params[:name]
        end

        value = setting.value.merge(value) unless setting.value.nil?

        # Remove null values
        value.delete_if { |k, v| v == nil }
        setting.value = value

        setting.save ?
            render :json => setting.value, :status => :created :
            render :json => setting.errors, :status => :unprocessable_entity

      end
 
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def destroy
  	begin
      session = current_session
      session.user.client.settings.where("section = ? and name = ?", params[:section], params[:name]).destroy_all

      head :no_content
      
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def destroy_section
  	begin
      session = current_session
      session.user.client.settings.where("section = ?", params[:section]).destroy_all

      head :no_content
      
    rescue Exception => exception
      error exception.message, :not_found
    end
  end


end

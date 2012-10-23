class UsersController < ApplicationController
  def new
    begin
      @user = User.new
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def index
    begin
      @users = User.all
      render :json => @users
    rescue Exception => exception
      error exception.message, :not_found
    end
  end

  def destroy
    begin
      @user = User.find(params[:id])
      @user.destroy
      head :no_content
    rescue Exception => exception
      error exception.message, :not_found
    end
  end
  
  def create
    begin
      @user = User.new(params[:user])
      if @user.save
        render :json => @user, :status => :created, :location => @user
      else
        render :json => @user.errors, :status => :unprocessable_entity 
      end
    rescue Exception => exception
      error exception.message, :not_found
    end

  end
end

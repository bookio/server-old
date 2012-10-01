class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @users = User.all
    render :json => @users
  end

  def destroy
    begin
      @user = User.find(params[:id])
      @user.destroy
      head :no_content
    rescue ActiveRecord::RecordNotFound
      error "User with ID #{params[:id]} not found.", :not_found
    end
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      render :json => @user, :status => :created, :location => @user
    else
      render :json => @user.errors, :status => :unprocessable_entity 
    end
  end
end

class UsersController < ApplicationController
  def new
  end

  def index
    @users = User.paginate(:page => params[:page], :per_page => 8)
  end

  def show
    @user = User.find(params[:id])
    @places = @user.places.paginate(:page => params[:page], :per_page => 10)
    @itineraries = @user.itineraries.paginate(:page => params[:page], :per_page => 10)
  end

end

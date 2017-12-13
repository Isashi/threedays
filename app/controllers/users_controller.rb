class UsersController < ApplicationController
  def new
  end

  def index
    @users = User.paginate(:page => params[:page], :per_page => 3)
  end

  def show
    @user = User.find(params[:id])
  end

end

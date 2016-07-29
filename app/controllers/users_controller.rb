class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index,:edit,:update,:destroy]
  before_action :correct_user , only: [:edit, :update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end
  def create
    @user = User.new(permit_params)
    if @user.save
      log_in(@user)
      redirect_to @user
      flash[:success] = "Welcome to Document Tracker"
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(permit_params)
      flash[:success] = "Your profile was successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end

  private
  def permit_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please login to continue"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end

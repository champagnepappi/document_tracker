class UsersController < ApplicationController
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
    else
      render 'edit'
    end
  end

  private
  def permit_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end

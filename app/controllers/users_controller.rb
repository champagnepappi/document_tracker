class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(permit_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end
  private
  def permit_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
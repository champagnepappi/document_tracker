class UsersController < ApplicationController
  before_action :already_signed_up , only: :new
  before_action :logged_in_user, except: [:new, :create]

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
      @user.send_activation_email
      # log_in(@user)
      flash[:success] = "An email was sent with activation instructions"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @documents = @user.documents
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

  def already_signed_up
    if current_user
      redirect_to root_url
      flash[:message] = "You are signed up"
    end
  end
end

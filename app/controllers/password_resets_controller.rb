class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit,:update]
  before_action :valid_user, only: [:edit,:update]
  before_action :check_expiration, only: [:edit,:update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Check your email for password reset instructions"
      redirect_to root_url
    else
      flash[:danger] = "Email address not found, please try again"
      render 'new'
    end
  end

  def edit
  end

  def update
    if password_blank?
      flash.now[:danger] = "Password can't be blank"
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "Password successfully reset"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:password,:password_confirmation)
  end

  def password_blank?
    params[:user][:password].blank?
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Password reset timeout"
      redirect_to new_password_reset_url
    end
  end

  #confirm valid user
  def valid_user
    unless (@user && @user.activated? && 
           @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end
end

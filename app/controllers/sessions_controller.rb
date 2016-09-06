class SessionsController < ApplicationController
  before_action :is_logged_in, except: :destroy
  def new
  end
  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      if user.activated?
      log_in user unless logged_in?
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
      else
        flash[:alert] = "Account not activated, check you email
          for activation instructions"
          redirect_to root_url
      end
    else
      flash[:danger] = "Sorry we had a problem logging you in. Please try again"
      render 'new'
    end
  end
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def is_logged_in
    if current_user
    redirect_to root_url 
    flash[:alert] = "You are already logged in"
    end
  end
end

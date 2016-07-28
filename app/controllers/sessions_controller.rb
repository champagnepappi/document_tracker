class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
    else
      flash[:danger] = "Sorry we had a problem logging you in. Please try again"
      render 'new'
    end
  end
  def destroy
  end
end

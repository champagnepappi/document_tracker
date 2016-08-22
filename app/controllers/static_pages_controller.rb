class StaticPagesController < ApplicationController
  def home
  end

  def contact
    @message = current_user.messages.build if logged_in?
  end
end

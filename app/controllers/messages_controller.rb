class MessagesController < ApplicationController

  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      redirect_to contact_path
      flash[:success] = "Message successfully submitted"
    else
      render 'static_pages/contact'
    end
  end

  private
  def message_params
   params.require(:message).permit(:name,:email,:message) 
  end
end

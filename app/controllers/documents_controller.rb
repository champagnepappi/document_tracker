class DocumentsController < ApplicationController
  def new
    @document = current_user.documents.build
  end

  def create
    @document = current_user.documents.build(document_params)
    if @document.save
      flash[:success] = "Document successfully created"
      redirect_to @document
    else
      render 'new'
      flash.now[:alert] = "There was a problem creating the document,
                        please try again"
    end
  end

  def show
    @document = Document.find(params[:id])
  end

  private
  def document_params
    params.require(:document).permit(:author, :title, :department,
                                   :content  )
  end
end

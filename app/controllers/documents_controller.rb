class DocumentsController < ApplicationController

  def index
    if params[:department]
      @documents = Document.where("department = ?", params[:department])
    elsif params[:search]
      @documents = Document.search(params[:search])
    else
    @documents = Document.all
    end
  end

  def new
    @document = current_user.documents.build
  end

  def create
    @document = current_user.documents.build(document_params)
    if @document.save
      flash[:success] = "Document successfully created"
      redirect_to current_user
    else
      render 'new'
      flash.now[:alert] = "There was a problem creating the document,
                        please try again"
    end
  end

  def show
    @document = Document.find(params[:id])
  end

  def edit
    @document = Document.find_by(id: params[:id])
  end

  def update
    @document = Document.find_by(id: params[:id])
    if @document.update_attributes(document_params)
      flash[:success] = "Document successfully updated"
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def destroy
    Document.find(params[:id]).destroy
    redirect_to request.referrer
  end

  private
  def document_params
    params.require(:document).permit(:author, :title, :department,:link,
                                   :content  )
  end
end

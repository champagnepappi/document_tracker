class DocumentsController < ApplicationController
  before_action :logged_in_user
   before_action :current_user, only: [:edit, :update]

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
    @document = Document.new
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
    redirect_to request.referrer || current_user
  end

  private
  def document_params
    params.require(:document).permit(:author, :title, :department,:link,:tag,
                                   :content  )
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please login to continue"
      redirect_to root_url
    end
  end
  
  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end

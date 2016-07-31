class DocumentsController < ApplicationController
  def new
    @document = Document.new
  end

  private
  def document_params
    params.require(:document).permit(:author, :title, :department,
                                  :link, :content  )
  end
end

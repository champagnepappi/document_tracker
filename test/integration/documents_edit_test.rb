require 'test_helper'

class DocumentsEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:santos)
    @document = documents(:one)
  end

  # test "unsuccessful edit" do
  #   log_in_as(@user)
  #   get edit_document_path(@document)
  #   patch document_path(@document), params: {
  #     document: {
  #       title: "",
  #       author: "",
  #       department: "",
  #       link: "alnflka",
  #       tag: "",
  #       content: ""
  #     }
  #   }
  #   assert_template 'documents/edit'
  #   assert flash.empty?
  # end
end

require 'test_helper'

class DocumentsAdditionTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:santos)
    @document = documents(:one)
  end
  test "add document with invalid params" do
    log_in_as(@user)
    get new_document_path
    assert_no_difference 'Document.count' do
    post documents_path params: {
      document: {
        title: "",
        author: " ",
        department: "sjhiosd",
        link: "iqihfiq",
        tag: "ihfiohoiwhiow",
        content: ""
      }
    }
    end
    assert_template 'new'
  end
end

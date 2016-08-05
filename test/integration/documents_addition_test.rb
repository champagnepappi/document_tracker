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

  test "add document with valid params" do
    log_in_as(@user)
    get new_document_path
    assert_difference 'Document.count', 1 do
      post documents_path params: {
        document: {
          title: "its my time",
          author: "that nigga",
          department: "Sports",
          link: "http://www.nana.com",
          tag: "hwuiuq9uiqui",
          content: "jkbsbkjsiwgiusguiagbjhasvbhsvhjs"
        }
      }
    end
    assert_redirected_to @user
  end
end

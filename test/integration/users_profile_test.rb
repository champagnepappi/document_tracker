require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:santos)
    @document = documents(:one)
  end

  test "users profile" do
    log_in_as(@user)
    get user_path(@user)
    #invalid document creation
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
    #valid document creation
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
    assert_redirected_to user_path(@user)
    follow_redirect!
    #delete a document
    assert_select 'a', text: 'delete'
    document = @user.documents.first
    assert_difference 'Document.count', -1 do
      delete document_path(document)
    end
    assert_redirected_to user_path(@user)
    #profile for another user
    get user_path(users(:shaz))
    assert_select 'a', text: 'delete', count: 0
  end
end

require 'test_helper'

class DocumentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @document = documents(:one)
    @user = users(:santos)
    @user2 = users(:shaz)
  end

  test "should get new" do
    log_in_as(users(:santos))
    get new_document_path
    assert_response :success
  end

  # test "redirect edit if not correct user" do
  #   log_in_as(@user2)
  #   assert_no_difference 'Document.count' do
  #     patch document_path(@document), params: {
  #       document: {
  #         title: "its my time",
  #         author: "that nigga",
  #         department: "Sports",
  #         link: "http://www.nana.com",
  #         tag: "hwuiuq9uiqui",
  #         content: "jkbsbkjsiwgiusguiagbjhasvbhsvhjs"
  #       }
  #     }
  #   end
  #   assert_redirected_to login_url
  # end

  test "should redirect create when not logged in" do
    assert_no_difference 'Document.count' do
      post documents_path, params: {
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
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Document.count' do
      delete document_path(@document), params: {
         id: @document
      }
    end
    assert_redirected_to root_url
  end

end

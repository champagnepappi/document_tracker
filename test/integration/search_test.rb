require 'test_helper'

class SearchTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:shaz)
    @doc = documents(:one)
  end

  test "searching a document" do
   log_in_as(@user) 
   get documents_path, params: {
     search: {
      title: @doc.title ,
      author: @doc.author,
      tag: @doc.tag,
      department: @doc.department

     }
   }
   assert_response :success
  end
end

require 'test_helper'

class DocumentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @document = documents(:one)
  end

  test "should get new" do
    get new_document_path
    assert_response :success
  end

end

require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  def setup
    @common_title = "| DocumentTracker"
  end
  test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Home #{@common_title}"
  end

  test "should get contact" do
    get :contact
    assert_response :success
    assert_select "title", "Contact #{@common_title}"
  end

end

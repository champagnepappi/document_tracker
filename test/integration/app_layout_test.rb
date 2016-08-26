require 'test_helper'

class AppLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:santos)
  end
  test "application layout links" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", contact_path
  end
end

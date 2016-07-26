require 'test_helper'

class AppLayoutTest < ActionDispatch::IntegrationTest
  test "application layout links" do
 get root_path
 assert_template 'static_pages/home'
 assert_select "a[href=?]", root_path
 assert_select "a[href=?]", contact_path
end
end

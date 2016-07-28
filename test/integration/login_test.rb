require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  test "login with invalid params" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {
      session: {
        name: "",
        password: ""
      }
    }
    assert_template 'sessions/new'
    assert_not flash.empty?
  end
end

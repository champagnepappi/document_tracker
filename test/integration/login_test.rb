require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:santos)
  end

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

  test "login with valid params followed by logout" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: {
      session: {
        name: @user.name,
        password: 'password'
      }
    }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    #user logging out in another window
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "login without remembering" do
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end

  test "current user should not login" do
   log_in_as(@user) 
   get login_path
   assert_redirected_to root_url
   assert_not flash.empty?
   assert_equal flash[:alert], "You are already logged in"
  end
end

require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:santos)
  end

  test "password reset" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    #input ivalid email
    post password_resets_path, params: {
      password_reset: {
        email: ""
      }
    }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    #input valid email
    post password_resets_path, params: {
      password_reset: {
        email: @user.email
      }
    }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    #password reset form
    user = assigns(:user)
    #with wrong email
    get edit_password_reset_path(user.reset_token, email: "")
    assert_redirected_to root_url
    #if user is not activated
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_url
    user.toggle!(:activated)
    #right email and wrong token
    get edit_password_reset_path("wrong token", email: user.email)
    assert_redirected_to root_url
    #right email and right token
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", user.email
    #invalid password and confirmation
    patch password_reset_path(user.reset_token),params: {
      email: user.email, user: {
        password: "hsjdi",
        password_confirmation: "uvhsuio"
      }
    }
   #submitting blank password 
    patch password_reset_path(user.reset_token),params: {
      email: user.email, user: {
        password: "",
        password_confirmation: "uvhsuio"
      }
    }
    assert_not flash.empty?
    assert_template 'password_resets/edit'
    #valid password and confirmation
    patch password_reset_path(user.reset_token),params: {
      email: user.email, user: {
        password: "123455",
        password_confirmation: "123455"
      }
    }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user

  end
end

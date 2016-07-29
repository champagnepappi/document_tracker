require 'test_helper'

class SignupTest < ActionDispatch::IntegrationTest

  test "signup with invalid params" do
    get new_user_path
    assert_template 'new'
    post users_path params: {
      user: {
        name: "",
        email: "santos@gmail.com",
        password: "hey",
        password_confirmation: ""
      }
    }
    assert_template 'new'

  end 

  test "signup with valid params with account activation" do
    get new_user_path
    assert_template "new"
    assert_difference 'User.count',1 do
      post users_path params: {
        user: {
          name: "vicky",
          email: "vicky@gmail.com",
          password: "einstein",
          passwword_confirmation: "einstein"
        }
      }
      # assert_redirected_to User.last
      # assert is_logged_in?
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    #login before activation
    log_in_as(user)
    assert_not is_logged_in?
    #invalid activation token
    get edit_account_activation_path("invalid token")
    assert_not is_logged_in?
    #valid token wrong email
    get edit_account_activation_path(user.activation_token, email: 'klszhvj')
    assert_not is_logged_in?
    #valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?



  end
end

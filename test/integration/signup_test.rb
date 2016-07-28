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

  test "signup with valid params" do
    get new_user_path
    assert_template "new"
    post users_path params: {
      user: {
        name: "vicky",
        email: "vicky@gmail.com",
        password: "einstein",
        passwword_confirmation: "einstein"
      }
    }
    assert_redirected_to User.last
    assert is_logged_in?
  end
    
end

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
    
end

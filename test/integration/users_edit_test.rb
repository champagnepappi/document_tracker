require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:santos)
  end

  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: {
      user: {
        name: "",
        email: "lesley@gmail.com",
        password: "13dis",
        password_confirmation: "akhcok"
      }
    }
    assert_template 'users/edit'
  end
end

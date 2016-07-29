require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:santos)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
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

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name = "Just Me"
    email = "me@gmail.com"
    patch user_path(@user), params: {
      user: {
        name: name,
        email: email,
        password: "",
        password_confirmation: ""
      }
    }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload #reload user's values from db and confirm that they
    #were successfully updated
    assert_equal @user.name, name
    assert_equal @user.email, email
  end


end

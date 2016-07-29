require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:santos)
    @second_user = users(:shaz)
  end

  test "index as a user and delete links" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'a[href=?]', user_path(@user), text: @user.name
    assert_select 'a[href=?]', user_path(@user), text: 'delete', method: :delete
    assert_difference 'User.count', -1 do
      delete user_path(@second_user)
    end
  end
end

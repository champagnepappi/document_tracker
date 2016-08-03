require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:santos)
    @user2 = users(:shaz)
  end

  test "index as a user and delete links" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'a[href=?]', user_path(@user), text: @user.name
    unless @user
    assert_select 'a[href=?]', user_path(@user), text: 'delete', method: :delete
    end
    assert_difference 'User.count', -1 do
      delete user_path(@user2)
    end
  end
end

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Anonymous", email: "shaz@gmail.com",
                     password: "12345",password_confirmation: "12345")
  end
  test "name presence" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "email presence" do
    @user.email = " "
    assert_not @user.valid?
  end
end

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

  test "authenticated? should return nil for user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  # test "associated documents should be destroyed" do
  #   @user.save
  #   @user.documents.create!(author: "sharon",
  #                          title: "this is acting",
  #                          link: "http://www.jfsjs.com",
  #                          department: "Business",
  #                          content: "fhiaqiijsfgigawigigigfijgigwi")
  #   assert_difference 'Document.count', -1 do
  #     @user.destroy
  #   end
  # end
end

require 'test_helper'

class UserMessageTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:shaz)
  end

  test "message submission with valid info" do
    log_in_as(@user)
    get contact_path
    assert_difference 'Message.count', 1 do
      post messages_path params: {
        message: {
          name: "justme",
          email: "ema@g.com",
          message: "svjhzvcjhzcjahfhjafk"
        }
      }
    end
    assert_redirected_to contact_path
    assert_not flash.empty?
  end

  test "message submission with invalid information" do
    log_in_as(@user)
    get contact_path
    assert_no_difference 'Message.count' do
      post messages_path params: {
        message: {
          name: "",
          email: "ch@hooli.com",
          message: ""
        }
      }
    end
    assert_template 'static_pages/contact'
    assert_not flash.empty?
  end

end

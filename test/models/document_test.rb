require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  def setup
    @user = users(:santos)
    @document = @user.documents.build(author: "shaniz",
                                      title: "anti hay",
                                      link: "http://www.wfsdas.com",
                                      tag: "ijqfiqpq",
                                      department: "Success",
                                      content: "hbvfwsijhfiqjoahiuqhiudqiu")
  end
  test "document should have user_id" do
    @document.user_id = nil
    assert_not @document.valid?
  end

  test "author,title, department and content should be present" do
    @document.title = " "
    @document.author = " "
    @document.department = ""
    @document.content = ""
    @document.tag = ""
    assert_not @document.valid?
  end

  test "document content should be at least 20 characters" do
    @document.content = "c" * 19
    assert_not @document.valid?
  end

  test "document should ordered with most recent first" do
    assert_equal Document.first, documents(:most_recent)
  end
end

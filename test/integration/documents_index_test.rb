require 'test_helper'

class DocumentsIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:santos)
    @document = documents(:two)
  end

  test "documents index" do
    log_in_as(@user)
    get documents_path
    assert_template 'documents/index'
    Document.all.each do |doc|
      assert_select 'a[href=?]', document_path(doc), text: doc.title
      assert_select 'a[href=?]', document_path(doc), text: 'delete',method: :delete
    end
    assert_difference 'Document.count', -1 do
      delete document_path(@document)
    end
  end
end

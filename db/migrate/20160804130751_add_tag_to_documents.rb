class AddTagToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :tag, :string
  end
end

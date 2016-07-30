class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :author
      t.string :title
      t.string :link
      t.string :department
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

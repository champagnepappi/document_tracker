class Document < ApplicationRecord
  belongs_to :user
  validates :author, presence: true
  validates :title , presence: true
  validates :link, presence: true
  validates :department, presence: true
  validates :content, presence: true
  DEPARTMENT = ["Success", "Life","Sports","Finance","Inspiration","Business"]

  def self.search(search)
      where("title LIKE ?","%#{search}")
  end
end

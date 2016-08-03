class Document < ApplicationRecord
  belongs_to :user
  validates :author, presence: true
  validates :title , presence: true
  validates :link, presence: true
  validates_format_of :link, with: URI.regexp
  validates :department, presence: true
  validates :content, presence: true
  DEPARTMENT = ["Success", "Life","Sports","Finance","Inspiration","Business"]

  def self.search(search)
      where("title LIKE ? OR author LIKE ? OR department LIKE ?","%#{search}%","%#{search}%","%#{search}%")
  end
end

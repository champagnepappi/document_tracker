class Document < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :author, presence: true
  validates :title , presence: true
  validates :link, presence: true
  validates :tag, presence: true, length: {minimum: 5}
  validates_format_of :link, with: URI.regexp
  validates :department, presence: true
  validates :content, presence: true, length: {minimum: 20}
  DEPARTMENT = ["Success", "Life","Sports","Finance","Inspiration","Business"]

  def self.search(search)
      where("title LIKE ? OR author LIKE ? OR department LIKE ? OR tag LIKE ?",
            "%#{search}%","%#{search}%","%#{search}%","%#{search}%")
  end
end


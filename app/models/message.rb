class Message < ApplicationRecord
  validates :name, presence: true, length: {maximum: 60}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 60},
    format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}
  validates :message, presence: true, length: {minimum: 5}

end

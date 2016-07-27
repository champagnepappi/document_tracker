class User < ApplicationRecord
  validates :name, presence: :true
  validates :email, presence: :true

  has_secure_password
  validates :password, length: {minimum: 5}

end

class User < ApplicationRecord
  # Validations
  has_secure_password
  has_secure_token :api_key
  validates :email, email: true, uniqueness: true, presence: true
  validates :password, confirmation: true, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true, length: { minimum: 8 }
end

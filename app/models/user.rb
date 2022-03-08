class User < ApplicationRecord
  # Validations
  has_secure_password
  has_secure_token :api_key
  validates :email, email: true, uniqueness: true, presence: true
  validates :password_digest, confirmation: true, presence: true
  validates :password, length: { minimum: 8 }
  validates :password_confirmation, presence: true
end

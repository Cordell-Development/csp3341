class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :saved_locations, dependent: :destroy
  has_many :locations, through: :saved_locations
  has_many :api_usages, dependent: :nullify

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  enum :role, { user: "user", admin: "admin" }
end

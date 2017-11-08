class User < ApplicationRecord
  validates :first_name, :last_name, :email, :password_digest, :location, presence: true
  validates :first_name, :last_name, length: { in: 3..255 }
  validates :email, uniqueness: true

  has_one :location
  has_many :orders
end

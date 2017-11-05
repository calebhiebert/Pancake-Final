class User < ApplicationRecord
  validates :first_name, :last_name, :email, :password, presence: true
  validates :first_name, :last_name, length: { in: 3..255 }

  has_one :location
  has_many :orders
end

class User < ApplicationRecord
  has_secure_password

  validates :first_name, :last_name, :email, :password, presence: true
  validates :first_name, :last_name, length: { in: 3..255 }

  has_one :location
  has_many :orders

  def save
    # code here
  end
end

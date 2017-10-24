class User < ApplicationRecord
  has_one :location
  has_many :orders
end

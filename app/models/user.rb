class User < ApplicationRecord
  has_one :location
  has_many :order
end

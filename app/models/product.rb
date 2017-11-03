class Product < ApplicationRecord
  has_many :order_product
  has_many :order, through: :order_product
end

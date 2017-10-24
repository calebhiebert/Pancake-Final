class Order < ApplicationRecord
  belongs_to :users
  has_many :order_products
  has_many :products, through: :order_products
end

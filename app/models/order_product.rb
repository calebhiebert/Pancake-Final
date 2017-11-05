class OrderProduct < ApplicationRecord
  validates :quantity, :price, :order, :product, presence: true

  belongs_to :order
  belongs_to :product
end

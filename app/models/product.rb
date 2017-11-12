class Product < ApplicationRecord
  validates :name, :description, :stock_quantity, :price, presence: true
  validates :name, length: { in: 3..255 }
  validates :description, length: { in: 3..16_000 }
  validates :stock_quantity, :price,
            numericality: { greater_than_or_equal_to: 0 }

  before_create do
    self.category = category.upcase unless category.nil?
  end

  before_update do
    self.category = category.upcase unless category.nil?
  end

  has_many :order_product
  has_many :order, through: :order_product
  has_many :images
end

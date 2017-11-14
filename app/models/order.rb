class Order < ApplicationRecord
  belongs_to :user

  has_many :order_product
  has_many :products, through: :order_product

  def subtotal
    st = 0

    order_product.each { |li| st += li.price * li.quantity }

    st
  end

  def tax
    subtotal = self.subtotal
    tax = pst + gst + hst

    subtotal * tax
  end

  def total
    subtotal + tax
  end
end

class OrdersController < ApplicationController
  def index
    @orders = Order.all
    render json: @orders, :include => :products
  end
end

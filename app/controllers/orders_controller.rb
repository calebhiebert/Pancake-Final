class OrdersController < ApplicationController
  before_action :require_auth

  def index
    @orders = Order.where(user: @calling_user)
    render json: @orders, include: :products
  end

  def create
    cart = session[:cart]
    @order = nil

    if cart.any?
      @order = Order.create(
        user: @calling_user,
        status: 'UNPAID',
        pst: @calling_user.location.province.pst,
        gst: @calling_user.location.province.gst,
        hst: @calling_user.location.province.hst
      )

      make_line_items(@order, cart)

      render json: @order, include: :products
    end
  end

  def show
    render json: Order.find(params[:orderid]), include: { order_product: {include: :product} }
  end

  private

  def make_line_items(order, cart)
    cart.each do |item|
      prd = Product.find(item.symbolize_keys[:product])

      OrderProduct.create(
        order: order,
        product: prd,
        quantity: item.symbolize_keys[:quantity],
        price: prd.price
      )
    end
  end
end

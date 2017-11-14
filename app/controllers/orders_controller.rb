class OrdersController < ApplicationController
  before_action :require_auth

  def index
    @orders = Order.where(user: @calling_user)
    render json: @orders, include: :products, except: :stripe_charge_id
  end

  def create
    cart = session[:cart]
    @order = nil

    unless cart.any?
      render json: { error: 'Cart is empty' }
      return
    end

    @order = Order.create(
      user: @calling_user,
      status: 'UNPAID',
      pst: @calling_user.location.province.pst,
      gst: @calling_user.location.province.gst,
      hst: @calling_user.location.province.hst
    )

    make_line_items(@order, cart)

    session.delete(:cart)
    session[:orderid] = @order.id

    render json: @order, include: :order_product, except: :stripe_charge_id
  end

  def show
    render json: Order.find(params[:orderid]),
           include: { order_product: { include: :product } },
           except: :stripe_charge_id
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

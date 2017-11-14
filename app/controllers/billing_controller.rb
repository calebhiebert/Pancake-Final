class BillingController < ApplicationController
  before_action :require_auth

  def make_payment
    Stripe.api_key = 'sk_test_4f6ByZyhkj5DL427l14LLz7O'

    token = params.require(:token)
    orderid = params.require(:orderid)

    order = Order.find(orderid)

    charge = Stripe::Charge.create(
      amount: (order.total * 100).to_i,
      currency: 'cad',
      description: 'Example Charge',
      source: token[:id]
    )

    order.stripe_charge_id = charge[:id]
    order.status = 'PAID'
    order.save

    render json: order, except: :stripe_charge_id
  end

  private

  def calc_subtotal
    sub = 0

    session[:cart].each do |item|
      sub += Product.find(item.symbolize_keys[:product]).price * item.symbolize_keys[:quantity]
    end

    @subtotal = sub
  end

  def calc_tax
    tax = 0

    tax += @calling_user.location.province.gst * @subtotal
    tax += @calling_user.location.province.pst * @subtotal
    tax += @calling_user.location.province.hst * @subtotal

    @tax = tax
  end
end

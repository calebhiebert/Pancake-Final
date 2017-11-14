class BillingController < ApplicationController
  before_action :require_auth

  def make_payment
    Stripe.api_key = 'sk_test_4f6ByZyhkj5DL427l14LLz7O'
    calc_subtotal
    calc_tax

    token = params.require(:token)

    charge = Stripe::Charge.create(
      amount: ((@subtotal + @tax) * 100).to_i,
      currency: 'cad',
      description: 'Example Charge',
      source: token[:id]
    )

    logger.info(charge)
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

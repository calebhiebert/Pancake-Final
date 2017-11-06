class CartController < ApplicationController
  def add_to_cart
    parms = add_params
    product = Product.find(parms['product_id'])

    if product.nil?
      render json: { error: 'Product not found' }, status: :not_found
    else
      session[:cart] = [] if session[:cart].nil?

      existing = session[:cart].find { |item| item['product'] == product.id }
      render json: existing

      if !existing.nil?
        existing[:quantity] = parms[:quantity]
      else
        session[:cart] << { product: product.id, quantity: parms[:quantity] }
      end

      # get
    end
  end

  def get
    session[:cart] = [] if session[:cart].nil?

    full_cart = []

    session[:cart].each do |item|
      product = Product.where(id: item[:product]).first

      next if product.nil? do
        full_cart << { product: product,
                       quantity: item[:quantity] }
      end
    end

    render json: session[:cart]
  end

  def clear
    session.delete(:cart)
  end

  private

  def add_params
    params.require(:cart).permit(:product_id, :quantity)
  end
end

class CartController < ApplicationController
  def add_to_cart
    session[:cart] = [] if session[:cart].nil?
    parms = add_params
    product = Product.find(parms['product_id'])

    if product.nil?
      render json: { error: 'Product not found' }, status: :not_found
    else
      remove_from_cart_by_product_id(product.id)
      session[:cart] << { product: product.id, quantity: parms[:quantity] }

      get
    end
  end

  def get
    session[:cart] = [] if session[:cart].nil?

    full_cart = []

    session[:cart].each do |item|
      item = item.symbolize_keys

      product = Product.find(item[:product])

      unless product.nil?
        full_cart << { product: product, quantity: item[:quantity] }
      end
    end
    render json: full_cart
  end

  def clear
    session.delete(:cart)
  end

  def remove
    product = Product.find(add_params[:product_id])

    if !product.nil?
      remove_from_cart_by_product_id(product.id)
      get
    else
      render json: { error: 'Item not found' }, status: :not_found
    end
  end

  def remove_from_cart_by_product_id(id)
    session[:cart].reject! { |item| item['product'] == id }
  end

  private

  def add_params
    params.require(:cart).permit(:product_id, :quantity)
  end
end

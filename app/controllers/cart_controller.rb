class CartController < ApplicationController
  def add_to_cart
    parms = add_params
    product = Product.find(parms['product_id'])

    if product.nil?
      render json: { error: 'Product not found' }, status: :not_found
    else
      session[:cart] = [] if session[:cart].nil?
      session[:cart] << { product: product, quantity: parms['quantity'] }
      get
    end
  end

  def get
    render json: session[:cart]
  end

  private

  def add_params
    params.require(:cart).permit(:product_id, :quantity)
  end
end

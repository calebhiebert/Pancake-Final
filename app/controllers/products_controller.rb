class ProductsController < ApplicationController
  def index
    @products = Product.all
    render json: @products
  end

  def create
    pars = params.permit(:name, :description, :stock_quantity, :price)
    @product = Product.new(pars)
    puts @product
    render json: @product
  end
end

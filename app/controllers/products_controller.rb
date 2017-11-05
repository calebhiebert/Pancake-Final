class ProductsController < ApplicationController
  before_action :set_product, only: %i[update show]

  def index
    @products = Product.all
    render json: @products
  end

  def show
    logger.info("Session: #{session[:last_viewed_product]}")
    session[:last_viewed_product] = 'wiggly jiggy'
    render json: @product
  end

  def create
    @product = Product.new(product_params)

    logger.debug product_params

    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, staus: :unprocessabe_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: @product.errors, status: :unprocessabe_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params
      .require(:product)
      .permit(:name, :description, :stock_quantity, :price)
  end
end

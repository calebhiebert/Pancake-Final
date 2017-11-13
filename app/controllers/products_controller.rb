class ProductsController < ApplicationController
  before_action :require_admin, only: %i[create update delete]
  before_action :set_product, only: %i[update show delete]

  def index
    @products = Product.all
    render json: @products, include: :images
  end

  def show
    render json: @product, include: :images
  end

  def create
    @product = Product.new(product_params)

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

  def delete
    @product.destroy
    render json: @product
  end

  def search
    if !params[:category].nil?
      products = Product.where('name like ? or description like ?',
                               "%#{params[:query]}%", "%#{params[:query]}%")
                        .where(category: params[:category])
    else
      products = Product.where('name like ? or description like ?',
                               "%#{params[:query]}%", "%#{params[:query]}%")
    end
    render json: products
  end

  def categories
    render json: Product.distinct.where.not(category: nil).pluck(:category)
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params
      .require(:product)
      .permit(:name, :description, :stock_quantity, :price, :category)
  end
end

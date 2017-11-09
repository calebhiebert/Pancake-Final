class ProvincesController < ApplicationController
  before_action :set_province, only: %i[show edit update destroy]

  def index
    @provinces = Province.all
    render json: @provinces
  end

  def show
    render json: @province
  end

  def create
    @province = Province.new(province_params)

    if @province.save
      show
    else
      render json: @province.errors
    end
  end

  def update
    if @province.update(province_params)
      show
    else
      render json: @province.errors
    end
  end

  def delete
    @province.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_province
    @province = Province.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def province_params
    params.require(:province).permit(:province_code, :name, :gst, :pst , :hst)
  end
end

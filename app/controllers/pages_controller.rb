class PagesController < ApplicationController
  before_action :set_page, only: %i[show edit update delete]

  # GET /pages
  # GET /pages.json
  def index
    @pages = Page.all
    render json: @pages
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    if @page.nil?
      render json: { error: 'NOT FOUND' }, status: :not_found
    else
      render json: @page
    end
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)
    if @page.save
      render json: @page, status: :created
    else
      render json: @page.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    if @page.update(page_params)
      render json: @page, status: :ok
    else
      render json: @page.errors, status: :unprocessable_entity
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def delete
    @page.destroy
    render json: @page
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_page
    @page = Page.find_by(title: params[:title])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def page_params
    params
      .require(:page)
      .permit(:title, :content)
  end
end

require 'digest'

class ImagesController < ApplicationController
  def upload
    product = Product.where(id: params[:productid]).first
    if product.nil?
      render json: { error: 'Product does not exist' }, status: :not_found
      return
    end

    image = params[:image]

    ext = File.extname(image.original_filename)
    ident = Digest::MD5.new
    ident << image.original_filename << Time.now.to_s

    img = Image.new(ident: ident.hexdigest, ext: ext, product: product)

    path = Rails.root.join('public', 'uploads', img.ident + img.ext)

    File.open(path, 'wb') do |file|
      file.write(image.read)
    end

    if img.save
      render json: img
    else
      File.open(path, 'wb') { |file| File.delete(file) }
      render json: img.errors
    end
  end

  def delete
    ident = params[:ident]
    img = Image.where(ident: ident).first

    if img.nil?
      render json: { error: 'Image does not exist' }, status: :not_found
      return
    end

    path = Rails.root.join('public', 'uploads', img.ident + img.ext)
    File.open(path, 'wb') { |file| File.delete(file) }

    img.destroy

    render json: img
  end

  def get
    ident = params[:ident]
    img = Image.where(ident: ident).first

    if img.nil?
      render json: { error: 'Image does not exist' }, status: :not_found
      return
    end

    send_file Rails.root.join('public', 'uploads', img.ident + img.ext), type: 'image/jpeg'
  end
end

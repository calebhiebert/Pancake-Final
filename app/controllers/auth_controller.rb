class AuthController < ApplicationController
  before_action :province, only: [:register]
  before_action :location, only: [:register]

  def register
    input = params.permit(:first_name, :last_name, :email, :password,
                          :password_confirmation, :address, :postal_code)

    if @province.nil?
      render json: { error: 'Invalid province code' }, status: :not_found
      return
    end

    if input[:password].empty?
      render json: { error: 'Password is required' },
             status: :unprocessable_entity
      return
    end

    if input[:password] != input[:password_confirmation]
      render json: { error: 'Passwords do not match' },
             status: :unprocessable_entity
      return
    end

    password_hash = BCrypt::Password.create(input[:password])

    user = User.new(first_name: input[:first_name],
                    last_name: input[:last_name],
                    email: input[:email],
                    password_digest: password_hash,
                    is_admin: false)

    @location.user = user

    if user.save
      session[:user] = user.id
      render json: user, include: :location
    else
      render json: user.errors
    end
  end

  def login
    info = params.require(:auth).permit(:password, :email)

    user = User.where(email: info[:email]).first

    unless user.nil?
      pass = BCrypt::Password.new(user[:password_digest])

      if pass == info[:password]
        session[:user] = user.id
        render json: { message: 'Login okay' }
      else
        render json: { error: 'Bad Login' }, status: :bad_request
      end
    end
  end

  def logout
    session.delete(:user)
  end

  private

  def province
    prov = params.permit(:province_code)
    @province = Province.where(province_code: prov[:province_code]).first
  end

  def location
    loc = params.require(:auth).permit(:postal_code, :address)
    @location = Location.new(address: loc[:address], postal_code: loc[:postal_code], province: @province)
  end
end

class AuthController < ApplicationController
  def register
    input = params
            .require(:auth)
            .permit(:first_name, :last_name, :email, :password,
                    :password_confirmation, :address, :postal_code,
                    :province_code)

    # province = Province.where(province_code: input[:province_code]).first

    # if province.nil?
    #   render json: { error: 'Invalid province code' }, status: :not_found
    #   return
    # end

    if input[:password].strip!.nil?
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
                    password: input[:password],
                    email: input[:email],
                    password_digest: password_hash,
                    is_admin: false)

    if user.save
      render json: user
    else
      logger.info('RROR')
      render json: user.errors
    end

    # location = Location.new(address: input[:address],
    #                         postal_code: input[:postal_code],
    #                         province: province)

    # render json: user
  end
end

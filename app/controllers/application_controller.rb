class ApplicationController < ActionController::API
  def require_auth
    @calling_user = User.eager_load(location: :province).where(id: session[:user]).first
    if @calling_user.nil?
      render json: { error: 'Not logged in' },
             status: :unauthorized
    end
  end

  def require_admin
    require_auth

    unless @calling_user.nil? || @calling_user.is_admin
      render json: { error: 'Admin is required' }, status: :unauthorized
    end
  end
end

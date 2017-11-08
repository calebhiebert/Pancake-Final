class UsersController < ApplicationController
  before_action :require_auth
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
    render json: @users, include: :location
  end

  def show
    render json: @user
  end

  def update
    if @user.update(user_params)
      show
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  def me
    render json: @calling_user
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.fetch(:user, {})
  end
end

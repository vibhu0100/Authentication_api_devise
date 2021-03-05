class Api::V1::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_params_exist, only: :create
  def create
    user = User.new(user_params)
    if user.save
      render json: { message: 'Signed Up' }, status: :ok
    else
      render json: { message: 'Sign up failed' }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def ensure_params_exist
    return if params[:name].present?
    render json: {
      message: 'Missing Parameter'},
      status: :bad_request
  end
end

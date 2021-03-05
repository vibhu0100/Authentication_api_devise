class Api::V1::SessionsController < Devise::SessionsController
  before_action :sign_in_params, only: :create
  before_action :load_user, only: :create
  def create
    if @user.valid_password?(sign_in_params[:password])
      sign_in "user", @user
      render json: {
        message: "Signed In",
        user: @user
      }, status: :ok
    else
      render json: {message: "Sign In failed"},
      status: :unauthorized
    end
  end

  private
  def sign_in_params
    params.permit(:email, :password)
  end

  def load_user
    @user = User.find_for_database_authentication(email: sign_in_params[:email])
    if @user
      return @user
    else
      render json: {
        message: "Cannot get user"
      },
      status: :failure
    end
  end
end

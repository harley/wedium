class UsersController < ApplicationController
  before_action :authenticate_user, only: [:current, :update_current]

  def create
    @user = User.create(user_params)
  end

  def current
    if current_user
      render 'current', locals: { user: current_user }
    else
      render json: {error: "Not authenticated."}
    end
  end

  def update_current
    if current_user
      current_user.update(user_update_params)
      if current_user.errors.empty?
        render 'current', locals: { user: current_user }
      else
        render json: {error: current_user.errors.full_messages.to_sentence}
      end
    else
      render json: {error: "Not authenticated."}
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username)
  end

  def user_update_params
    params.require(:user).permit(:email, :password, :username, :bio, :image)
  end

  def current_user
    @current_user ||= User.find_by(id: @current_user_id)
  end

  # docs https://apidock.com/rails/ActionController/HttpAuthentication/Token/ControllerMethods/authenticate_or_request_with_http_token
  def authenticate_user
    if request.headers['Authorization'].present?
      # inspect headers
      # p request.headers.select{ |key,val| key.starts_with?("HTTP_") }

      authenticate_with_http_token do |token|
        begin
          jwt_payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first
          p "JWT payload: #{jwt_payload}"
          @current_user_id = jwt_payload['id']
        rescue JWT::VerificationError => e
          render json: {error: "Error: #{e.message}"}, status: 400
        end
      end
    end
  end
end

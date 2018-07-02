class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :underscore_params!

  private

  def current_user
    return @current_user if @current_user

    authenticate_user
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
          # p "JWT payload: #{jwt_payload}"
          @current_user_id = jwt_payload['id']
        rescue JWT::VerificationError => e
          render json: {error: "Error: #{e.message}"}, status: 401
        end
      end
    end
  end

  def require_user
    unless current_user
      render json: { error: 'Unauthenticated' }, status: 403
    end
  end

  def underscore_params!
    params.deep_transform_keys!(&:underscore)
  end
end

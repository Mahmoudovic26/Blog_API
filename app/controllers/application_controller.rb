# In app/controllers/application_controller.rb
class ApplicationController < ActionController::API
    before_action :authorize_request
    def authenticate_request
        @current_user = AuthorizeApiRequest.call(request.headers).result
        render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
      end
    # Fallback action for unmatched routes
    def route_not_found
      render json: { error: 'Not Found' }, status: :not_found
    end
    
    private
    
    def authorize_request
      token = request.headers['Authorization']
      secret_key = Rails.application.credentials.secret_key_base
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      begin
        decoded = JWT.decode(header, secret_key)[0]
        @current_user = User.find(decoded["user_id"])
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  
    def encode_token(payload)
      JWT.encode(payload, Rails.application.credentials.secret_key_base)
    end
  end
  
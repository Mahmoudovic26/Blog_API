# In app/controllers/application_controller.rb
class ApplicationController < ActionController::API
    include Tokenable  # Include the module for token encoding
  
    before_action :authorize_request
  
    # Handles unmatched routes
    def route_not_found
      render json: { error: 'Not Found' }, status: :not_found
    end
  
    private
  
    def authorize_request
      header = request.headers['Authorization']
      Rails.logger.info("Authorization Header: #{header}")
  
      token = header.split(' ').last if header.present?
      Rails.logger.info("Token: #{token}")
  
      if token.present?
        begin
          decoded = decode_token(token)
          @current_user = find_current_user(decoded['user_id'])
          Rails.logger.info("Current User: #{@current_user.inspect}")
        rescue => e
          handle_authorization_error(e)
        end
      else
        render_error('Missing token', :unauthorized)
      end
    end
  
    def decode_token(token)
      JsonWebToken.decode(token)
    end
  
    def find_current_user(user_id)
      User.find(user_id)
    rescue ActiveRecord::RecordNotFound
      raise 'User not found'
    end
  
    def handle_authorization_error(error)
      Rails.logger.error(error)
      render_error(error, :unauthorized)
    end
  
    def render_error(message, status)
      render json: { error: message }, status: status
    end
  end
  
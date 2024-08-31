# app/controllers/concerns/authenticable.rb
module Authenticable
    extend ActiveSupport::Concern
  
    included do
      before_action :authenticate_user
    end
  
    def authenticate_user
      token = request.headers['Authorization']&.split(' ')&.last
      decoded = JsonWebToken.decode(token)
      @current_user = User.find(decoded[:user_id]) if decoded
    rescue
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end
  
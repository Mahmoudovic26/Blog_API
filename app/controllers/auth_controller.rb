# app/controllers/auth_controller.rb
class AuthController < ApplicationController
    def signup
      user = User.new(user_params)
      if user.save
        render json: { token: JsonWebToken.encode(user_id: user.id) }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def login
      user = User.find_by(email: params[:email])
      if user&.authenticate(params[:password])
        render json: { token: JsonWebToken.encode(user_id: user.id) }, status: :ok
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end
  end
  
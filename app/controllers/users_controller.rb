# In app/controllers/users_controller.rb
class UsersController < ApplicationController
    # Skip authorization for the 'create' and 'sign_in' actions
    skip_before_action :authorize_request, only: [:create, :sign_in]
  
    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def sign_in
      user = User.find_by(email: sign_in_params[:email])
      
      if user&.authenticate(sign_in_params[:password])
        token = encode_token(user_id: user.id)
        render json: { token: token }, status: :ok
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end
  
    def sign_in_params
      params.require(:user).permit(:email, :password)
    end
  end
  
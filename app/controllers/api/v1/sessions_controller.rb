class Api::V1::SessionsController < ApplicationController

  def show 
    current_user ? head(:ok) : head(:unauthorized)
  end 

  def create
    # byebug
    @user = User.where(email: params[:email]).first
    # jwt generate
    
    # jwt = JWT.encode(
    #   {
    #     user_id: @user.id, exp: (Time.now + 2.weeks).to_i
    #   },
    #   Rails.application.secrets.secret_key_base,
    #   'HS256'
    # )
    if @user&.valid_password?(params[:password])
        jwt = WebToken::encode(@user)
        render json: {
          user: @user,
          token: jwt,
        }, 
        locals: {
          token: jwt,
        }, 
        status: :created
    else
        render json: {error: 'invalid_credentials'}, status: :unauthorized
    end
  end

  def destroy
    if nilify_token && current_user.save
      head(:ok)
    else
      head(:unauthorized)
    end
  end

  private 
  
  def nilify_token
    current_user&.authentication_token = nil
  end
end

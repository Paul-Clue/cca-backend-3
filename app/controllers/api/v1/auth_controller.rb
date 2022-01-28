class Api::V1::AuthController < ApplicationController
# class Api::V1::AuthController < ApiController
  # skip_before_action :authorized, only: [:create], :raise => false
  skip_before_action :verify_authenticity_token
  skip_before_action :authorized, :raise => false
  # before_action :authorized

  def create
      user = User.find_by(email: user_login_params[:email])
      if user && user.authenticate(user_login_params[:password])
        
          token = issue_token(user)
        render json: {user: UserSerializer.new(user), jwt: token}
      else
        render json: { error: 'That user could not be found' }, status: 401
      end
    end

  def show
      user = User.find_by(id: user_id)
      if logged_in?
          render json: user
      else
          render json: { error: 'No user could be found'}, status: 401
      end
  end

  private
  def user_login_params
    params.require(:auth).permit(:email, :password)
  end
end
# class Api::V1::UsersController < ApplicationController
class Api::V1::UsersController < ApiController
  # skip_before_action :authorized, only: [:create]
  # skip_before_action :authorized, :raise => false

  def index
    # @users = User.select("id, username, email, phone_number, user_type, release_date, employment_date, residence").all
    @users = User.all
    render json: @users.to_json
  end

  # def show
  #   @user = User.select("id, username, email")
  #   render json: @user.to_json
  # end

  def profile
    @user = User.find(params[:id])
    render json: {user: current_user}
    # render json:  @user.to_json
  end

  def update
    @us = User.all

    @us.each do |v|
      if v.id == params[:id].to_i
        v.update(user_params)
        render json: v.to_json
        head :no_content
      end
    end
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
        @user.save
        @token = issue_token(@user)
        render json: { user: @user, jwt: @token }
    else
      render json: { error: 'failed to create user' }, status: :not_acceptable
    end
  end

  def destroy
    @use = User.all
    @use.each do |v|
      if v.id == params[:id].to_i
        v.destroy
        head :no_content
      end
    end
  end

  def total_time_until_employ
    @date = User.total_employ_time
    # @date.each do |d|
    #   @temp = d.release_date
    #   @temp2 = d.employment_date
    #   @temp3 = (@temp2 - @temp).to_i

    # end
    render json: @date
  end

  def user_locations
    all = User.users_by_location
    render json: all
  end

  def all_user_employment_status
    all = User.users_empoyment_status
    render json: all
  end

  private

  def user_params
    # params.require(:user).permit(:username, :password, :email)
    # params.require.permit(:username, :password, :email)
    # params.permit(:username, :password, :email, :img, :user_type, :phone_number, :address, :release_date, :manager, :employment_date, :employment_type, :employed, :work_hours, :residence)
    params.require(:user).permit(:username, :password, :email, :img, :user_type, :phone_number, :address, :release_date, :manager, :employment_date, :employment_type, :employed, :work_hours, :residence)
  end

  def set_user
    @user = User.find_by(email: user_params[:email])
  end
end
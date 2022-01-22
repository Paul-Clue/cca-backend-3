# class Api::V1::UsersController < ApplicationController
class Api::V1::UsersController < ApiController
  # skip_before_action :authorized, only: [:create]
  # skip_before_action :authorized, :raise => false
  require 'securerandom'


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

  def update_password
    @us = User.all

    @us.each do |v|
      if v.email == user_params[:email]
        # v.update(user_params)

        @email_token = SecureRandom.base64(10)
        v.email_code = @email_token
        v.save
        UserMailer.correct_email_check(v.email, @email_token).deliver_now
        render json: v.to_json
        # head :no_content
      end
    end
  end

  def code_verify_password
    @new_user = User.find_by(email_code: user_params[:email_code])
    # puts "This is the code #{params[:email_code]}"
    puts "This is the code #{@new_user.id}"
    if @new_user
      @new_user.update(user_params)
      @new_user.email_code = ''
      @new_user.save
      render json: { success: 'success' }, status: 200
    else
      render json: { error: 'fail' }, status: 401
    end
  end

  def user_email_validate_token

  end

  def create
    pass_check = User.all
    pw_used_already = false

    pass_check.each do |pw|
      if pw.email == user_params[:email]
        pw_used_already = true
      end
    end

    if pw_used_already
      render json: { error: 'This email is already being used.' }, status: 401
    else
      @user_new = User.new(user_params)
      # if @user.valid?
      # GENERATE TOKEN FOR EMAIL VALIDATION AND SAVE IT TO A NEW FIELD IN THE DATABASE
      # CALLED 'user_email_validate_token'---@user.user_email_validate_token = token----

      if @user_new.save
        puts "Something ran"
          @token = issue_token(@user_new)
          # render json: { user: @user_new, jwt: @token }
          #CALL THE MAILER AND PASS THE TOKEN AND THE EMAIL. THEN SEND A JSON MESSAGE TO SHOW SUCCESS.

          @user_email = User.find(@user_new.id).email
          @email_token = SecureRandom.base64(10)
          @user_new.email_code = @email_token
          @user_new.save
          UserMailer.correct_email_check(@user_email, @email_token).deliver_now
          render json: { user: @user_new, jwt: @token }
      else
        render json: { error: 'failed to create user' }, status: :not_acceptable
      end
    end
  end

# WRITE AN ACTION FOR VALIDATING THE EMAIL AFTER THE USER HAS ENTERED THE TOKEN IN THE VALIDATON FIELD 
# AND PRESSES SEND TO ACTIVATE A FETCH REQUEST.
# THIS ACTION SHOULD ALSO ERASE THE 'user_email_validate_token' FROM THE TABLE.
# THIS ACTION SHOULD ALSO CREATE AND SEND THE JWT TOKEN FOR THE USER AFTER A SUCCESSFUL EMAIL VALIDATION.
def code_verify
  @new_user = User.find_by(email_code: user_params[:email_code])
  # puts "This is the code #{params[:email_code]}"
  puts "This is the code #{@new_user.id}"
  if @new_user
    @new_user.email_code = ''
    @new_user.save
    render json: { success: 'success' }, status: 200
  else
    render json: { error: 'fail' }, status: 401
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

  # -----STATISTICS-----
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

  #-----MAILER-----
  def send_mail
    puts "This is the random string: #{SecureRandom.base64(10)}"
    # @user_email = User.where(email: 'paulclue20@gmail.com').first.email
    # @user_email = User.find_by(email: 'paulclue20@gmail.com').email
    # @token = 'VG9rZW4='
    # UserMailer.correct_email_check(@user_email, @token).deliver_now
  end

  private

  def user_params
    # params.require(:user).permit(:username, :password, :email)
    # params.require.permit(:username, :password, :email)
    # params.permit(:username, :password, :email, :img, :user_type, :phone_number, :address, :release_date, :manager, :employment_date, :employment_type, :employed, :work_hours, :residence)
    params.require(:user).permit({avatars: []}, :email_code, :username, :password, :email, :img, :user_type, :phone_number, :address, :release_date, :manager, :employment_date, :employment_type, :employed, :work_hours, :residence)
  end

  def set_user
    @user = User.find_by(email: user_params[:email])
  end
end
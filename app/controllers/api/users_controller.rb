class Api::UsersController < ApplicationController

  def create
    @user = User.create(user_params)

    if @user.valid?
      render json: @user
    else
      render_error
    end
  end

  def login
    @user = User.find_by(email_address: login_params[:email_address])
    @success = @user && @user.authenticate(login_params[:password]) ? true : false

    if @success
      render json: @user
    else
      render_error
    end
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation, :name)
  end

  def login_params
    params.require(:user).permit(:email_address, :password)
  end

end

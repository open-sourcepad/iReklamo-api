class Api::UsersController < ApplicationController

  def create
    @user = User.create(user_params)
  end

  def login
    @user = User.find_by(email_address: login_params[:email_address])
    @success = @user && @user.authenticate(login_params[:password]) ? true : false
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation, :name)
  end

  def login_params
    params.require(:user).permit(:email_address, :password)
  end

end

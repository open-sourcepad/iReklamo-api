class Api::UsersController < ApplicationController

  def create
    @user = User.create(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation, :name)
  end

end

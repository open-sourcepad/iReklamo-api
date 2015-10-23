class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session

  def authenticate_token_from_user!
    @user = User.find_by(access_token: request.env["HTTP_AUTHORIZATION"])
    render json: {success: "false", message: "Unauthorized Access"}, status: 401 unless @user
  end

  def render_error
    render json: 'Error', status: :unprocessable_entity
  end
end

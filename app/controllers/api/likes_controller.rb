class Api::LikesController < ApplicationController
  before_filter :authenticate_token_from_user!

  def create
    new_like = Like.create(create_like_params)

    if new_like.valid?
      render json: new_like
    else
      render_error
    end
  end

  private

  def create_like_params
    {
      user_id: params[:user_id],
      complaint_id: params[:complaint_id]
    }
  end
end

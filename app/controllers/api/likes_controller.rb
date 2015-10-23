class Api::LikesController < ApplicationController
  def create
    new_like = Like.create(create_like_params)

    render json: new_like
  end

  private

  def create_like_params
    {
      user_id: params[:user_id],
      complaint_id: params[:complaint_id]
    }
  end
end

class Api::CommentsController < ApplicationController
  before_filter :authenticate_token_from_user!

  def create
    new_comment = Comment.create(create_comment_params)

    render json: new_comment
  end

  private

  def create_comment_params
    comment_params.merge(user_id: params[:user_id], complaint_id: params[:complaint_id])
  end

  def comment_params
    params.require(:comment).permit(:title, :description)
  end
end

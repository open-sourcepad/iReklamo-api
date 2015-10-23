class Api::Users::ComplaintsController < ApplicationController

  before_action :authenticate_token_from_user!

  def create
    @complaint = @user.complaints.create(complaint_params)
  end

  private

  def complaint_params
    params.require(:complaint).permit(:image, :title, :description, :latitude, :longitude, :category)
  end

end

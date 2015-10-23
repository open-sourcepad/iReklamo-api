class Api::Users::ComplaintsController < ApplicationController

  before_action :authenticate_token_from_user!
  before_action :find_complaint, only: [:update, :show]

  def create
    @complaint = @user.complaints.create(complaint_params)
  end

  def update
    @complaint.update(complaint_params)
  end

  def show
  end

  def destroy
    @complaint.destroy if @complaint
  end

  private

  def complaint_params
    params.require(:complaint).permit(:image, :title, :description, :latitude, :longitude, :category)
  end

  def find_complaint
    @complaint = @user.complaints.find(params[:id])
  end

end

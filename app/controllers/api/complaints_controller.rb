class Api::ComplaintsController < ApplicationController

  before_action :find_complaint, only: [:show]

  # Get complaints 20 miles radius from user's location
  def index
    if params[:latitude] && params[:longitude]
      @complaints = Complaint.near([params[:latitude], params[:longitude]], 32.1869, units: :km)
    else
      @complaints = Complaint.all
    end
  end

  def show
  end

  protected

  def find_complaint
    @complaint = Complaint.find(params[:id])
  end

end

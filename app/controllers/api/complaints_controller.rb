class Api::ComplaintsController < ApplicationController

  # Get complaints 20 miles radius from user's location
  def index
    if params[:latitude] && params[:longitude]
      @complaints = Complaint.near([params[:latitude], params[:longitude]], 32.1869, units: :km)
    else
      @complaints = Complaint.all
    end
  end

end

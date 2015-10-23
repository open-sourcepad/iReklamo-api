class Api::ComplaintsController < ApplicationController

  before_action :find_complaint, only: [:show]

  # Get complaints 20 miles radius from user's location
  def index
    if params[:latitude] && params[:longitude]
      @complaints = find_near [params[:latitude], params[:longitude]], params[:proximity], params[:cached_ids]
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

  private

  def find_near center, radius = 1, cached_ids
    cached_ids = 0 unless cached_ids.present?

    Complaint.near(center, radius).where.not(id: cached_ids)
  end
end

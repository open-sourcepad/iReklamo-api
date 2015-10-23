class Complaint < ActiveRecord::Base

  belongs_to :user

  validates :title, :description, :latitude, :longitude, :category, presence: true
  
end

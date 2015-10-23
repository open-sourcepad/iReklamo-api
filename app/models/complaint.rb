class Complaint < ActiveRecord::Base

  belongs_to :user

  validates :title, :description, :latitude, :longitude, :category, presence: true

  has_attached_file :image, default_url: "/images/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  has_many :comments
end

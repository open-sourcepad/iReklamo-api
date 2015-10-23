# == Schema Information
#
# Table name: complaints
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  title              :string
#  description        :text
#  latitude           :float
#  longitude          :float
#  category           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Complaint < ActiveRecord::Base

  belongs_to :user

  validates :title, :description, :latitude, :longitude, :category, presence: true

  has_attached_file :image, default_url: "/images/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  geocoded_by :street_address

end

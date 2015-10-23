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

require 'test_helper'

class ComplaintTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

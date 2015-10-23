# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :string
#  complaint_id :integer
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :complaint
  belongs_to :user
end


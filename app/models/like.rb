# == Schema Information
#
# Table name: likes
#
#  id           :integer          not null, primary key
#  complaint_id :integer
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Like < ActiveRecord::Base
  belongs_to :complaint
  belongs_to :user

  validates_uniqueness_of :user_id, scope: [:complaint_id]
end


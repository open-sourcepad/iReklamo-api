class Like < ActiveRecord::Base
  belongs_to :complaint
  belongs_to :user

  validates_uniqueness_of :user_id, scope: [:complaint_id]
end


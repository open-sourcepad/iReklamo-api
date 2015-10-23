class User < ActiveRecord::Base

  has_secure_password validations: true

  validates_presence_of :password, on: :create

end

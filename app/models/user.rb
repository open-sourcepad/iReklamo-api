class User < ActiveRecord::Base

  has_secure_password validations: true

  validates_presence_of :password, on: :create

  after_create :generate_access_token

  def generate_access_token
    self.access_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(access_token: random_token)
    end
  end

end

class User < ActiveRecord::Base

  has_secure_password validations: true

  validates :email_address, uniqueness: true
  validates :email_address, :password, presence: true

  has_many :complaints
  has_many :comments
  has_many :likes

  after_create :generate_access_token

  def generate_access_token
    self.access_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(access_token: random_token)
    end
    save
  end
end

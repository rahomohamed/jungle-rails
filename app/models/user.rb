class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 3 }

  def self.authenticate_with_credentials(email, password)
    email = email.downcase.strip
    user = User.find_by_email(email)
    user && user.authenticate(password) ? user : nil
  end
end

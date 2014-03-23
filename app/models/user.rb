class User < ActiveRecord::Base
  attr_reader :password

  validates :email, presence: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  def password=(password)
    @password = password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end
end

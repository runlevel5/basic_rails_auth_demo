class User < ActiveRecord::Base
  attr_reader :password

  validates :email, presence: true, uniqueness: true

  validates :password, presence: true, on: :create
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, if: Proc.new { |u| u.password.present? }

  def password=(password)
    @password = password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end
end

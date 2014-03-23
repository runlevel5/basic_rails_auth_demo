class UserAuthentication
  def self.authenticate(email:, password:)
    user = User.find_by_email(email)

    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      # do nothing
      nil
    end
  end
end
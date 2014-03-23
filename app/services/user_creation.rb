class UserCreation
  def self.create(email:, password:, password_confirmation:)
    u = User.new(email: email, password: password, password_confirmation: password)

    if u.save
      u
    else
      u.errors
    end
  end
end
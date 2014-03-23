require 'spec_helper'

describe User do
  describe '#password=' do
    let(:password) { 'abc+123' }
    let!(:user) { User.new(password: password) }

    it 'sets #password_hash and #password_salt' do
      expect(user.password).to eq password
      expect(user.password_salt).not_to be_nil
      expect(user.password_hash).to eq BCrypt::Engine.hash_secret(password, user.password_salt)
    end
  end
end

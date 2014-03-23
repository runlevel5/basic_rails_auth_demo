require 'spec_helper'

describe UserAuthentication do
  describe '.authenticate' do
    let!(:user) { UserCreation.create(email: 'hello@example.com', password: '123', password_confirmation: '123') }

    context 'when password matches' do
      it 'returns user' do
        expect(UserAuthentication.authenticate(email: user.email, password: '123')).to eq user
      end
    end

    context 'when password does not match' do
      it 'returns nil' do
        expect(UserAuthentication.authenticate(email: user.email, password: 'abc')).to be_nil
      end
    end
  end
end
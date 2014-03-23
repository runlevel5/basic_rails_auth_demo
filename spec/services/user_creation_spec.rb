require 'spec_helper'

describe UserCreation do
  describe '.create' do
    it 'creates new user' do
      expect do
        password = 'abc+123'
        result = UserCreation.create(
          email: 'hello@example.com',
          password: password,
          password_confirmation: password)

        expect(result.email).to eq 'hello@example.com'
        expect(result.password_salt).not_to be_nil
        expect(result.password_hash).to eq BCrypt::Engine.hash_secret(password, result.password_salt)
      end.to change { User.count }.by(1)
    end

    context 'when there is errors' do
      it 'returns errors' do
        errors = ActiveModel::Errors.new(User.new).add(:base, 'an error has occured')
        allow_any_instance_of(User).to receive(:save).and_return(false)
        allow_any_instance_of(User).to receive(:errors).and_return(errors)

        expect do
          result = UserCreation.create(
            email: 'hello@example.com',
            password: 'abc+123',
            password_confirmation: 'abc+123')
          expect(result).to eq errors
        end.not_to change { User.count }
      end
    end
  end
end